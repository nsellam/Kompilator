%{
#include <stdio.h>
#include "interpreteur.h"
%}

%error-verbose
%token tADD tMUL tSOU tDIV
%token tCOP tAFC
%token tJMP tJMF
%token tINF tSUP tEQU
%token tPRI
%token tLABEL
%token tEND

%start Input

%union

 {
   int integer;
}
%token <integer> tNB

/** On parcourt tout le code assembleur et on charge dans le tableaux insctrutions toutes les lignes de code, pour pouvoir ensuite
parcourir facilement les instructions avec l'ip comme index **/
%%
Input : Instrs Input
      | ;

Instrs :
      tADD tNB tNB tNB {add_instruct(1, $2, $3, $4);}
    | tMUL tNB tNB tNB {add_instruct(2, $2, $3, $4);}
    | tSOU tNB tNB tNB {add_instruct(3, $2, $3, $4);}
    | tDIV tNB tNB tNB {add_instruct(4, $2, $3, $4);}
    | tCOP tNB tNB {add_instruct(5, $2, $3, -1);}
    | tAFC tNB tNB {add_instruct(6, $2, $3, -1);}
    | tJMP tNB {add_instruct(7, $2, -1, -1);}
    | tJMF tNB tNB {add_instruct(8, $2, $3, -1);}
    | tINF tNB tNB tNB {add_instruct(9, $2, $3, $4);}
    | tSUP tNB tNB tNB {add_instruct(10, $2, $3, $4);}
    | tEQU tNB tNB tNB {add_instruct(11, $2, $3, $4);}
    | tPRI tNB {add_instruct(12, $2, -1, -1);}
    | tEND {add_instruct(13,-1,-1,-1);};
%%
int yyerror(char *s) {
  fprintf(stdout, "Erreur de Syntaxe de la Mort dans l'interpretation : %s\n", s);
  return 0;
}



void main() {
    init_interp();
    yyparse();
    interprete();
}
