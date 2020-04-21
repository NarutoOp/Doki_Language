%{
#include "parserfile.tab.c"
void yyerror (char *s);
int yylex();
%}
%%
"show"				   {return print;}
"end"				   {return exit_command;}
[a-zA-Z]			   {yylval.id = yytext[0]; return identifier;}
[0-9]+                 {yylval.num = atoi(yytext); return number;}
[ \t\n]                ;
[-+=;]           	   {return yytext[0];}
"*"					   { return MULT; }
"/"           		   { return DIV; }
.                      {ECHO; yyerror ("unexpected character");}

%%
int yywrap (void) {return 1;}