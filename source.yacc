%{
#include <stdio.h>
#include "symbol.h"
#include "label.h"
%}

%error-verbose
%token tMAIN
%token tCONST tINT tVOID tTEXT
%token tADD tSUB tMUL tDIV tEQU
%token tVIR tPV tAO tAF tPO tPF tGUI
%token tPRINT tIF tWHILE tFOR tELSE tRET
%token tOR tAND tNOT
%token tLT tGT tLE tGE tEGALEGAL
%token tESPER
%start Input
%union
 {
  int integer;
  char * string;
 }
%token <integer> tNB
%token <string> tID
%type <integer> Expr

%right tEQU
%left tADD tSUB
%left tMUL tDIV
%left tOR tAND tNOT
%%

Input : DFonction Input
      | {printf("THE END\n");};

DFonction : Type tID tPO Params tPF Body
          | DMain;

DMain : tINT tMAIN tPO tPF Body
      | tMAIN tPO tPF Body
      | tMAIN tPO tPF tVOID tPF Body
      | tINT tMAIN tPO tVOID tPF Body;

Type : tVOID
     | tINT;

Adresse : tESPER tID;

Params : Type tID SuiteParams {putInTable($2, 0, 0);}
       | Type tMUL tID SuiteParams {putInTable($3, 0, 0);}
       | ;

SuiteParams : tVIR tINT tID SuiteParams
            | tVIR tINT tMUL tID SuiteParams
            | ;

Body : tAO Instrs tAF;

Instrs : If Instrs
       | While Instrs
       | Print Instrs
       | Decl Instrs
       | Affect Instrs
       | Declaff Instrs
       | Adresse Instrs
       | Return
       | Body
       | ;

If : tIF tPO Cond tPF {char * nom = ".IF"; char nomLabel[10]; sprintf(nomLabel,"%s%d",nom, nb_if); ass_jmf(getTemp(1), nomLabel);} Body {ajouterLabelIf(nb_lignes);};

While : tWHILE tPO Cond tPF {char * nom = ".WHILE"; char nomLabel[10]; sprintf(nomLabel,"%s%d",nom, nb_while); ass_jmf(getTemp(1), nomLabel);} Body {ajouterLabelWhile(nb_lignes);};

Print : tPRINT tPO tGUI Text tGUI tPF tPV
      | tPRINT tPO tID tPF tPV {ass_pri(getFromTable($3));};

Text : tTEXT Text
     | ;

Return : tRET tID tPV
       | tRET tNB tPV;

Cond : Expr tLT Expr {ass_inf(getTemp(2),getTemp(2),getTemp(1)); suppTemp(1);}
     | Expr tGT Expr {ass_sup(getTemp(2),getTemp(2),getTemp(1)); suppTemp(1);}
     | Expr tLE Expr
     | Expr tGE Expr
     | Expr tEGALEGAL Expr {ass_equ(getTemp(2),getTemp(2),getTemp(1)); suppTemp(1);}
     | Cond tOR Cond
     | Cond tAND Cond
     | tPO Cond tPF
     | tNOT Cond;

Expr : Expr tADD Expr {ass_add(getTemp(2),getTemp(2),getTemp(1)); suppTemp(1);}
     | Expr tSUB Expr {ass_sou(getTemp(2),getTemp(2),getTemp(1)); suppTemp(1);}
     | Expr tMUL Expr {ass_mul(getTemp(2),getTemp(2),getTemp(1)); suppTemp(1);}
     | Expr tDIV Expr {ass_div(getTemp(2),getTemp(2),getTemp(1)); suppTemp(1);}
     | tPO Expr tPF {$$ = $2;}
     | tNB {ass_afc(addTemp(),$1);}
     | tID {if (getFromTable($1) == -1){printf("Fatal Error : Variable not found\n"); exit;} ass_cop(addTemp(),getFromTable($1));}
     | tESPER tID {int adresse; if (getFromTable($2) == -1){printf("Fatal Error : Variable not found\n"); exit;} else {adresse = getFromTable($2);} ass_cop(addTemp(),getFromTableByAddr(adresse));}
     | tSUB tPO Expr tPF %prec tMUL {$$ = -$3;};

Decl : tINT SuiteDecl tPV
     | tINT tMUL SuiteDecl tPV;

SuiteDecl : SuiteDecl tVIR tID {putInTable($3, 0, 0);}
          | tID {putInTable($1, 0, 0);};

Declaff : tINT tID tEQU Expr tPV {putInTable($2,1,0); ass_cop(getFromTable($2),getFromTable($2)-1);}
        | tINT tMUL tID tEQU Adresse tPV {putInTable($3,1,0); ass_cop(getFromTable($3),getFromTable($3)-1);}
        | tCONST tINT tID tEQU Expr tPV {putInTable($3,1,1); ass_cop(getFromTable($3),getFromTable($3)-1);}
        | tCONST tINT tMUL tID tEQU Adresse tPV {putInTable($4,1,1); ass_cop(getFromTable($4),getFromTable($4)-1);};

Affect : tID tEQU Expr tPV {ass_cop(getFromTable($1),getTemp(1)); suppTemp(1);}
       | tMUL tID tEQU Expr tPV {ass_cop(getFromTable($2),getTemp(1)); suppTemp(1);};

%%
int yyerror(char *s) {
  fprintf(stdout, "Fatal Error de Syntaxe de la Mort : %s\n", s);
  return 0;
}

void main() {
  FILE * pFile=fopen("outAssembleur","w");
  initTable(pFile);
  initTableLabels(pFile);
  yyparse();
  /*finalizeTable();
  finalizeTableLabels();*/
  fclose(pFile);

  pFile=fopen("outAssembleur","r+");
  remplacerLabels(pFile);
  // Faire la seconde passe sur l'assembleur
  fclose(pFile);

}
