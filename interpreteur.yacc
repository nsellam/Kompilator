%{
#include <stdio.h>

int memoire [1024];
int ip = 0;
%}

%error-verbose
%token tADD tMUL tSOU tDIV tCOP tAFC tJMP tJMF tINF tSUP tEQU tPRI
%start Input

%union
 {
  int integer;
 }
%token <integer> tNB
%%
Input : Instrs Input
    | ;


Instrs : tADD tNB tNB tNB {memoire[$2] = memoire[$3] + memoire[$4]; printf("memoire[%d] = %d (memoire[%d]=%d + memoire[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);}
    | tMUL tNB tNB tNB {memoire[$2] = memoire[$3] * memoire[$4]; printf("memoire[%d] = %d (memoire[%d]=%d * memoire[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);}
    | tSOU tNB tNB tNB {memoire[$2] = memoire[$3] - memoire[$4]; printf("memoire[%d] = %d (memoire[%d]=%d - memoire[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);}
    | tDIV tNB tNB tNB {memoire[$2] = memoire[$3] / memoire[$4]; printf("memoire[%d] = %d (memoire[%d]=%d / memoire[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);}
    | tCOP tNB tNB {memoire[$2] = memoire[$3]; printf("memoire[%d] = %d",$2,memoire[$2]);}
    | tAFC tNB tNB {memoire[$2] = $3; printf("memoire[%d] = %d",$2,memoire[$2]);}
    | tJMP tNB {ip = $2; printf("ip = %d",$2);}
    | tJMF tNB tNB {if (memoire[$2] == 0) ip = $3; printf("ip = %d",$3);}
    | tINF tNB tNB tNB {memoire[$2] = (memoire[$3] < memoire[$4]) ? 1 : 0; printf("memoire[%d] = %d (memoire[%d]=%d < memoire[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);}
    | tSUP tNB tNB tNB {memoire[$2] = (memoire[$3] > memoire[$4]) ? 1 : 0; printf("memoire[%d] = %d (memoire[%d]=%d > memoire[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);}
    | tEQU tNB tNB tNB {memoire[$2] = (memoire[$3] == memoire[$4]) ? 1 : 0; printf("memoire[%d] = %d (memoire[%d]=%d == memoire[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);}
    | tPRI tNB {printf("print memoire[%d]: %d\n",$2,memoire[$2]);};

%%
int yyerror(char *s) {
  fprintf(stdout, "Fatal Error de Syntaxe de la Mort : %s\n", s);
  return 0;
}



void main() {
    yyparse();
}
