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
    | ;

DFonction : Type tID tPO Params tPF Body
    | DMain;

DMain : tINT tMAIN tPO tPF Body
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

Expr : Expr tADD Expr {ass_add(addTemp(),$1,$3);}
    | Expr tSUB Expr {ass_sou(addTemp(),$1,$3);}
    | Expr tMUL Expr {ass_mul(addTemp(),$1,$3);}
    | Expr tDIV Expr {ass_div(addTemp(),$1,$3);}
    | tPO Expr tPF {$$ = $2;}
    | tNB
    | tID {$$ = getFromTable($1);}
    /* Que fait cette ligne en dessous ?? */
    /*| tSUB tPO Expr tPF %prec tMUL*/;

Decl : tINT tID SuiteDecl tPV {putInTable($2, 0, 0);};

SuiteDecl : tVIR tID {putInTable($2, 0, 0);} SuiteDecl
    | ;

Declaff : tINT tID tEQU Expr tPV {putInTable($2,1,0);ass_afc(getFromTable($2),$4);}
    | tCONST tINT tID tEQU Expr tPV {putInTable($3,1,1);} ;

Affect : tID tEQU Expr tPV {putInTable($1,1,0);};

%%
int yyerror(char *s) {
  fprintf(stdout, "Fatal Error de Syntaxe de la Mort : %s\n", s);
  return 0;
}



void main() {
    yyparse();
}
