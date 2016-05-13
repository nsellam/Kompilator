all: exe interpreteur

exe: y.tab.c lex.yy.c symbol.c label.c fonctions.c
	gcc -g y.tab.c lex.yy.c symbol.c label.c fonctions.c -ll -o exe

y.tab.c: source.yacc
	yacc -d source.yacc

lex.yy.c: source.lex
	flex source.lex

interpreteur: y.interp.c lexinterp.yy.c interpreteur.c
	gcc -g y.interp.c lexinterp.yy.c interpreteur.c -ll -o interpreteur

y.interp.c: interpreteur.yacc
	yacc -d interpreteur.yacc -o y.interp.c

lexinterp.yy.c: interpreteur.lex
	flex -o lexinterp.yy.c interpreteur.lex

clean:
	rm -f y.tab.c y.tab.h lex.yy.c y.interp.c y.interp.h lexinterp.yy.c
