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

%%
program:
	| program statement { cout << "Result : "<<$2<<endl;}
	;

statement: exp SEMI

exp:
	INTERAL_LITERAL { $$ = $1; }
	| FLOAT_LITERAL { $$ = $1; }
	| exp PLUS exp { $$ = $1 + $3; }
	| exp MINUS exp { $$ = $1 - $3; }
	| exp MULT exp { $$ = $1 * $3; }
	| exp DIV exp { $$ = $1 / $3; }
	;