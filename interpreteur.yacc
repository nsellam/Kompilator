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
%token <integer> tIF
%token <integer> tWHILE
%%
Input : Instrs Input
      | ;

Instrs :
      tADD tNB tNB tNB {/*memoire[$2] = memoire[$3] + memoire[$4];
                        printf("mem[%d] = %d (mem[%d]=%d + mem[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);*/
                        add_instruct(1, $2, $3, $4);}
    | tMUL tNB tNB tNB {/*memoire[$2] = memoire[$3] * memoire[$4];
                        printf("mem[%d] = %d (mem[%d]=%d * mem[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);*/
                        add_instruct(2, $2, $3, $4);}
    | tSOU tNB tNB tNB {/*memoire[$2] = memoire[$3] - memoire[$4];
                        printf("mem[%d] = %d (mem[%d]=%d - mem[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);*/
                        add_instruct(3, $2, $3, $4);}
    | tDIV tNB tNB tNB {/*memoire[$2] = memoire[$3] / memoire[$4];
                        printf("mem[%d] = %d (mem[%d]=%d / mem[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);*/
                        add_instruct(4, $2, $3, $4);}
    | tCOP tNB tNB {/*memoire[$2] = memoire[$3];
                    printf("mem[%d] = %d",$2,memoire[$2]);*/
                    add_instruct(5, $2, $3, -1);}
    | tAFC tNB tNB {/*memoire[$2] = $3;
                    printf("mem[%d] = %d",$2,memoire[$2]);*/
                    add_instruct(6, $2, $3, -1);}
    | tJMP tNB {/*ip = $2;
                printf("\nip = %d",$2);*/
                add_instruct(7, $2, -1, -1);}
    | tJMF tNB tNB {/*if (memoire[$2] == 0) ip = $3;
                    printf("\nip = %d",$3);*/
                    add_instruct(8, $2, $3, -1);}
    | tINF tNB tNB tNB {/*memoire[$2] = (memoire[$3] < memoire[$4]) ? 1 : 0;
                        printf("mem[%d] = %d (mem[%d]=%d < mem[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);*/
                        add_instruct(9, $2, $3, $4);}
    | tSUP tNB tNB tNB {/*memoire[$2] = (memoire[$3] > memoire[$4]) ? 1 : 0;
                        printf("mem[%d] = %d (mem[%d]=%d > mem[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);*/
                        add_instruct(10, $2, $3, $4);}
    | tEQU tNB tNB tNB {/*memoire[$2] = (memoire[$3] == memoire[$4]) ? 1 : 0;
                        printf("mem[%d] = %d (mem[%d]=%d == mem[%d]=%d)",$2,memoire[$2],$3,memoire[$3],$4,memoire[$4]);*/
                        add_instruct(11, $2, $3, $4);}
    | tPRI tNB {/*printf("print mem[%d]: %d",$2,memoire[$2]);*/
                add_instruct(12, $2, -1, -1);}
    | tLABEL tIF {printf(".IF%d\n",$2);}
    | tLABEL tWHILE {printf(".WHILE%d\n",$2);}
    | tEND {/*printf("Fin du programme");*/
            add_instruct(13,-1,-1,-1);};
%%
int yyerror(char *s) {
  fprintf(stdout, "Fatal Error de Syntaxe de la Mort dans l'interpretation : %s\n", s);
  return 0;
}



void main() {
    init_interp();
    yyparse();
    interprete();
}
