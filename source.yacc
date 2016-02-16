%{
#include <stdio.h>
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
        | Return
        | Body
        | ;

 If : tIF tPO Cond tPF Body;

 While : tWHILE tPO Cond tPF Body;

 Print : tPRINT tPO tGUI Text tGUI tPF tPV
       | tPRINT tPO tID tPF tPV;

 Text : tTEXT Text
      | ;

 Return : tRET tID;

 Cond : Expr Comparateur Expr
      | Cond tOR Cond
      | Cond tAND Cond
      | tPO Cond tPF
      | tNOT Cond;

 Comparateur : tLT | tGT | tLE | tGE | tEGALEGAL;

 Expr : Expr tADD Expr
      | Expr tSUB Expr
      | Expr tMUL Expr
      | Expr tDIV Expr
      | tPO Expr tPF
      | tNB
      | tID
      | tSUB tPO Expr tPF %prec tMUL;

 Decl : tINT tID tEQU tNB {
      | tCONST Decl ;

%%
int yyerror(char *s) {
  fprintf(stdout, "Fatal Error de Syntaxe de la Mort : %s\n", s);
  return 0;
}
