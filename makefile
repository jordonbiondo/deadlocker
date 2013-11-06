deadlocker:  lex.yy.c y.tab.c lims.o deadlocker.c
	gcc -std=gnu99 -Wall -g lex.yy.c y.tab.c lims.o deadlocker.c -o deadlocker

lims.o: lims.c lims.h
	gcc -std=gnu99 -Wall -c lims.c

lex.yy.c: dl-syntax.l
	flex dl-syntax.l

y.tab.c: dl-parse.y lex.yy.c
	yacc -d dl-parse.y

clean: 
	rm -f lex.yy.c y.tab.c y.tab.h deadlocker

default: deadlocker      
