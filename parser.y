%(
#include<iostream>
using namespace std;
extern "C" void yyerror(char *s);
extern "C" int yyparse();
%)

%union{
	int intval;
	float flaotval;
}

%start program

%token <intval> INTEGER_LITERAL
%token <floaval> FLOAT_LITERAL
%token SEMI
%type <floatval> exp
%type <floatval> statement
%left PLUS MINUS
%left MULT DIV