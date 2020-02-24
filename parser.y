%{
#include<iostream>
using namespace std;
extern "C" void yyerror(char *s);
extern "C" int yyparse();
%}

%union{
	int intVal;
	float floatVal;
}

%start program

%token <intVal> INTEGER_LITERAL
%token <floatVal> FLOAT_LITERAL
%token SEMI
%type <floatVal> exp
%type <floatVal> statement
%left PLUS MINUS
%left MULT DIV

%%
program:
	| program statement { cout << "Result : "<<$2<<endl;}
	;

statement: exp SEMI

exp:
	INTEGER_LITERAL { $$ = $1; }
	| FLOAT_LITERAL { $$ = $1; }
	| exp PLUS exp { $$ = $1 + $3; }
	| exp MINUS exp { $$ = $1 - $3; }
	| exp MULT exp { $$ = $1 * $3; }
	| exp DIV exp { $$ = $1 / $3; }
	;
%%
int main(int argc,char **argv){
	if(argc < 2){
		cout << "Enter parsing file !"<<endl;
		exit(1);
	}
	FILE *sourcefile = fopen(argv[1],"r");

	if(!sourcefile){
		cout<<"Could not open source file "<<argv[1]<<endl;
		exit(1);
	}
	yyin = sourcefile;

	yyparse();
}

void yyerror(char *s){
	cerr << s <<endl;
}