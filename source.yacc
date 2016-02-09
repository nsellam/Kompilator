%{
#include <stdio.h>
%}

%token tMAIN tCONST tINT tFLOAT tVOID tADD tSUB tMUL tDIV tEQU tVIR tPV tAO tAF tPO tPF tGUI tPRINT tIF tWHILE tFOR tELSE tRET tOR tAND tNOT tLT tGT tLE tGE tEGALEGAL
%start Input
%union
 {
  int NBint;
  float NBfloat;
  char * string;
 }
%token <NBint> tNB
%token <NBfloat> tNEB
%token <string> tID
%%
   Input : DFonction Input
         | ;

DFonction : Type tID tPO Params tPF Body;
   
 Type : tVOID
      | tINT
      | tFLOAT;
   
Params : Type tID SuiteParams
       | ;
   
 SuiteParams : tVIR tINT tID SuiteParams
             | ;
   
 Body : tAO Instrs tAF;
   
 Instrs : If Instrs 
        | While Instrs
        | Print Instrs
        | Decl Instrs
        | Return Instrs
        | Body
        | ;

 If : tIF tPO Cond tPF Body;

 While : tWHILE tPO Cond tPF Body;

 Print : tPRINT tPO tGUI Text tGUI tPF tPV
       | tPRINT tPO tID tPF tPV;

 Text : tID Text 
      | ; 

 Return : tRET tID;

 Cond : Expr Comparateur Expr
      | Cond tOR Cond
      | Cond tAND Cond
      | tPO Cond tPF
      | tNOT Cond;

 Comparateur : tLT | tGT | tLE | tGE | tEGALEGAL;

Expr : tNB tADD tNB
     | tNB tSUB tNB
     | tNB tMUL tNB
     | tNB tDIV tNB
     | tNEB tADD tNEB
     | tNEB tSUB tNEB
     | tNEB tMUL tNEB
     | tNEB tDIV tNEB

     | Expr tADD Expr 

     | tNB
     | tSUB Expr %prec NEG
     | ;

 ExprFLOAT : tNEB | tID ;

 Decl : tINT tID tEQU tNB
      | tFLOAT tID tEQU tNEB 
      | tCONST Decl ;

%%
int yyerror(char *s) {
  fprintf(stderr, "Fatal Error de Syntaxe de la Mort : %s\n", s);
  return 1;
}
