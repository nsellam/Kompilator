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
     | tINT ;

Params : Type tID SuiteParams
       | ;

SuiteParams : tVIR tINT tID SuiteParams
            | ;

Body : tAO Instrs tAF;

Instrs : If Instrs
       | While Instrs
       | Print Instrs
       | Decl Instrs
       | Affect Instrs
       | Declaff Instrs
       | Return
       | Body
       | ;

If : tIF {ajouterLabelIf(nb_lignes);} tPO Cond tPF Body;

While : tWHILE {ajouterLabelWhile(nb_lignes);} tPO Cond tPF Body;

Print : tPRINT tPO tGUI Text tGUI tPF tPV
      | tPRINT tPO tID tPF tPV {ass_pri(getFromTable($3));};

Text : tTEXT Text
     | ;

Return : tRET tID;

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
     | tSUB tPO Expr tPF %prec tMUL {$$ = -$3;};

Decl : tINT SuiteDecl tPV;

SuiteDecl : SuiteDecl tVIR tID {putInTable($3, 0, 0);}
          | tID {putInTable($1, 0, 0);};

Declaff : tINT tID tEQU Expr tPV {putInTable($2,0,0); ass_cop(getFromTable($2),$4);}
        | tCONST tINT tID tEQU Expr tPV {ass_cop(getFromTable($3),$5);} ;

Affect : tID tEQU Expr tPV {ass_cop(getFromTable($1),getTemp(1)); suppTemp(1);};

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

}
