output: lex.yy.c 
	g++ lex.yy.c

lex.yy.c: parserfile.tab.c lexfile.lex
	flex lexfile.lex

parserfile.tab.c: parserfile.y
	bison parserfile.y

