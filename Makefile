FLEX=flex
BISON=bison
CC=gcc

PROGRAMA = semantico
LEXICO = lexico.l
SINTATICO = sintatico.y

$(PROGRAMA): $(LEXICO) $(SINTATICO)
	$(BISON) -d $(SINTATICO)
	$(FLEX) $(LEXICO)
	$(CC) -c *.c -I. -w
	$(CC) *.o -o $(PROGRAMA) -w	
	rm -f *.yy.c
	rm -f *.tab.c
	rm -f *.tab.h
	rm -f *.o
	rm -f *.exe
