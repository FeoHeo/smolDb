%option noyywrap 

/* To simplify process */

%{
    #include <stdio.h>

    #define YY_DECL int yylex()

    #include "sampleCalc.tab.h"

%}

%%

[\t]    ; //Ignore tabs
[0-9]+  {yylval = atof(yytext); return VAR;}
[0-9]+\.[0-9]+  {yylval = atof(yytext); return VAR;} 
"+"     {return PLUS;}
"-"     {return MINUS;}
"*"     {return MULTIPLY;}
"/"     {return DIVIDE;}
%%