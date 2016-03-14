%{
  //du code C (définition)
  #include "y.interp.h"
%}

NB [0-9]+

%%
^1        {return tADD;}
^2        {return tMUL;}
^3        {return tSOU;}
^4        {return tDIV;}
^5        {return tCOP;}
^6        {return tAFC;}
^7        {return tJMP;}
^8        {return tJMF;}
^9        {return tINF;}
^A        {return tSUP;}
^B        {return tEQU;}
^C        {return tPRI;}
{NB}      {yylval.integer = atoi(yytext); return tNB;}

%%
