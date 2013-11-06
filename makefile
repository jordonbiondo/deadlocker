deadlocker: # lex.yy.c y.tab.c deadlocker.c
	gcc -g lex.yy.c y.tab.c deadlocker.c -o deadlocker

lex.yy.c: dl-syntax.l
	flex dl-syntax.l

y.tab.c: dl-parse.y lex.yy.c
	yacc -d dl-parse.y

clean: 
	rm -f lex.yy.c y.tab.c y.tab.h deadlocker

default: deadlocker      
