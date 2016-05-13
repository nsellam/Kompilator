%{
  //du code C (définition)
  #include "y.interp.h"
%}

NB [0-9]+

%%
ADD        {return tADD;}
MUL        {return tMUL;}
SUB        {return tSOU;}
DIV        {return tDIV;}
COP        {return tCOP;}
AFC        {return tAFC;}
JMP        {return tJMP;}
JMF        {return tJMF;}
INF        {return tINF;}
SUP        {return tSUP;}
EQU        {return tEQU;}
PRI        {return tPRI;}
END        {return tEND;}
@	   {}
{NB}       {yylval.integer = atoi(yytext); return tNB;}

%%
