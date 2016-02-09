%{
  //du code C (définition)
  #include <stdio.h>
  #include "y.tab.h"
%}

NB [0-9]+
TEXT [A-Za-z0-9_]+

%%
[ \t]         {printf("[ ]");}
"main"        {printf("[main]"); return tMAIN;}
"const"       {printf("[const]"); return tCONST;}
"int"         {printf("[int]"); return tINT;}
"float"       {printf("[float]"); return tFLOAT;}
"void"        {printf("[void]"); return tVOID;}
"if"          {printf("[if]"); return tIF;}
"while"       {printf("[while]"); return tWHILE;}
"for"         {printf("[for]"); return tFOR;}
"else"        {printf("[else]"); return tELSE;}
"return"      {printf("[return]"); return tRET;}
"or"          {printf("[or]"); return tOR;}
"and"         {printf("[and]"); return tAND;}
"not"         {printf("[not]"); return tNOT;}
">"           {printf("[>]"); return tGT;}
"<"           {printf("[<]"); return tLT;}
">="          {printf("[>=]"); return tGE;}
"<="          {printf("[<=]"); return tLE;}
"=="          {printf("[==]"); return tEGALEGAL;}
"+"           {printf("[+]"); return tADD;}
"-"           {printf("[-]"); return tSUB;}
"*"           {printf("[*]"); return tMUL;}
"/"           {printf("[/]"); return tDIV;}
"="           {printf("[=]"); return tEQU;}
","           {printf("[,]"); return tVIR;}
"\n"          {printf("[\\n]");}
";"           {printf("[;]"); return tPV;}
"{"           {printf("[{]"); return tAO;}
"}"           {printf("[}]"); return tAF;}
"("           {printf("[(]"); return tPO;}
")"           {printf("[)]"); return tPF;}
"\""          {printf("[\"]"); return tGUI;}
"print"       {printf("[print]"); return tPRINT;}
{NB}"e"("+"|"-")?{NB}         {printf("[nEb::%f]", atof(yytext)); yylval.NBfloat = atof(yytext); return tNEB;}
{NB}          {printf("[nb::%d]",atoi(yytext)); yylval.NBint = atoi(yytext); return tNB;}
{TEXT}        {printf("[id::%s]",yytext); yylval.string = yytext; return tID;}

%%
void main(void) {
  yylex();
}
