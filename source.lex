%{
  //du code C (définition)
  #include <stdio.h>
  #include "y.tab.h"
%}

NB [0-9]+
E [Ee]["+"|"-"]?{NB}
ID [A-Za-z][A-Za-z0-9_]*
TEXT [A-Za-zéèàçùêâîûôëï0-9"-"\']+

%%
[ \t]         {printf("[ ]");}
"main"        {printf("[main]"); return tMAIN;}
"const"       {printf("[const]"); return tCONST;}
"int"         {printf("[int]"); return tINT;}
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
{NB}{E}?      {printf("[entier::%d]", atoi(yytext)); yylval.integer = atoi(yytext); return tNB;}
{ID}        {printf("[id::%s]",yytext); yylval.string = yytext; return tID;}
{TEXT}        {printf("[text::%s]",yytext); yylval.string = yytext; return tTEXT;}

%%
void main(void) {
  yyparse();
}
