all: exe

exe: y.tab.c lex.yy.c 
	gcc y.tab.c lex.yy.c -ll -o exe

y.tab.c: source.yacc 
	yacc -d source.yacc

lex.yy.c: source.lex
	flex source.lex

clean:
	rm -f y.tab.c y.tab.h lex.yy.c
