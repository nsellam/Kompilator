%{
#include <stdio.h>
#include "symbol.h"
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
| {printf("fin\n");};

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

If : tIF tPO Cond tPF Body;

While : tWHILE tPO Cond tPF Body;

Print : tPRINT tPO tGUI Text tGUI tPF tPV
      | tPRINT tPO tID tPF tPV {ass_pri(getFromTable($3));};

Text : tTEXT Text
     | ;

Return : tRET tID;

Cond : Expr Comparateur Expr
     | Cond tOR Cond
     | Cond tAND Cond
     | tPO Cond tPF
     | tNOT Cond;

Comparateur : tLT | tGT | tLE | tGE | tEGALEGAL;

Expr : Expr tADD Expr {ass_add(addTemp(),getTemp(1),getTemp(2)); suppTemp();}
     | Expr tSUB Expr {ass_sou(addTemp(),getTemp(1),getTemp(2)); suppTemp();}
     | Expr tMUL Expr {ass_mul(addTemp(),getTemp(1),getTemp(2)); suppTemp();}
     | Expr tDIV Expr {ass_div(addTemp(),getTemp(1),getTemp(2)); suppTemp();}
     | tPO Expr tPF {$$ = $2;}/*comme Expr est de type int, on lui donne la valeur du nombre*/
     | tNB {ass_afc(addTemp(),$1);}
     | tID {if (getFromTable($1) == -1){printf("Fatal Error : Variable not found\n"); exit;} ass_afc(addTemp(),getFromTable($1));}
     | tSUB tPO Expr tPF %prec tMUL {$$ = -$3;};

Decl : tINT SuiteDecl; 
/*Les variables sont stockées dans la mémoire dans le sens inverse des déclarations*/

SuiteDecl : tID tVIR SuiteDecl {putInTable($1, 0, 0);}
          | tID tPV {putInTable($1, 0, 0);};

Declaff : tINT tID tEQU Expr tPV {putInTable($2,1,0); ass_cop(getFromTable($2),$4);}
        | tCONST tINT tID tEQU Expr tPV {putInTable($3,1,1);} ;

Affect : tID tEQU Expr tPV {ass_cop(getFromTable($1),getTemp()); suppTemp();};

%%
int yyerror(char *s) {
  fprintf(stdout, "Fatal Error de Syntaxe de la Mort : %s\n", s);
  return 0;
}



void main() {
  initTable();
  yyparse();
  finalizeTable();
}
