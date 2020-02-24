%{
#include<iostream>
#include<cstring>
using namespace std;
extern "C" int yylex();
#include "parser.tab.c" //define the tokens
%}

%%
 
[0-9]+		  { yylval.intVal = atoi(yytext); return INTEGER_LITERAL; }
[0-9]+.[0-9]+ { yylval.floatVal = atof(yytext); return FLOAT_LITERAL; } 
"+"           { return PLUS; }
"-"           { return MINUS; }
"*"           { return MULT; }
"/"           { return DIV; }
";"           { return SEMI;}
[\t\r\n\f]    ; /* ignore whitespace */

%%
/* Code */
int yywrap(){
	return 0;
}

