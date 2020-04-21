%{
void yyerror (char *s);
int yylex();
#include<iostream>
#include<cstring>

#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
using namespace std;
int symbols[52];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
%}

%union {int num; char id;}         /* Yacc definitions */
%start line
%token print
%token exit_command
%token <num> number
%token <id> identifier
%type <num> line exp term 
%type <id> assignment
%left MULT DIV

%%

/* descriptions of expected inputs     corresponding actions (in C) */

line    : assignment ';'		{;}
		| exit_command ';'		{exit(EXIT_SUCCESS);}
		| print exp ';'			{printf("Answer is : %d\n", $2);}
		| line assignment ';'	{;}
		| line print exp ';'	{printf("Answer is : %d\n", $3);}
		| line exit_command ';'	{exit(EXIT_SUCCESS);}
        ;

assignment : identifier '=' exp  { updateSymbolVal($1,$3); }
			;
exp    	: term                  {$$ = $1;}
       	| exp '+' term          {$$ = $1 + $3;}
       	| exp '-' term          {$$ = $1 - $3;}
       	| exp MULT term			{$$ = $1 * $3;}
		| exp DIV term			{$$ = $1 / $3;}
       	;
term   	: number                {$$ = $1;}
		| identifier			{$$ = symbolVal($1);} 
        ;

%%                     /* C code */

int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

/* returns the value of a given symbol */
int symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}


int main(int argc, char **argv){
	if(argc < 2){
		/* cout << "Enter parsing file !"<<endl; */
		/* exit(1); */

		int i;
		for(i=0; i<52; i++) {
			symbols[i] = 0;
		}

	}
	else{
	FILE *sourcefile = fopen(argv[1],"r");

	if(!sourcefile){
		cout<<"Could not open source file "<<argv[1]<<endl;
		exit(1);
	}
	

	yyin = sourcefile;
	}

	yyparse();
}


void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 