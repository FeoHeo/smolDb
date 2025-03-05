all: sampleCalc

sampleCalc.tab.c sampleCalc.tab.h:	sampleCalc.y
	bison -t -v -d sampleCalc.y

lex.yy.c: sampleCalc.l sampleCalc.tab.h
	flex sampleCalc.l

sampleCalc: lex.yy.c sampleCalc.tab.c sampleCalc.tab.h
	gcc -o sampleCalc sampleCalc.tab.c lex.yy.c

clean:
	rm sampleCalc sampleCalc.tab.c lex.yy.c sampleCalc.tab.h sampleCalc.output
