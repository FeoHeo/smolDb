%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex(void);
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);

%}

%token VAR

%token PLUS 
%token MINUS 
%token MULTIPLY 
%token DIVIDE

%%

calculation: 
    | calculation line
;

line: '\n'
    | VAR {printf("Result: %f\n" , $1);}
;
%%

typedef struct NUM {
    union val {
        int ival;
        float fval;
    } storedVal;
} NUM;


NUM* int_to_NUM(int numInput) {
    NUM *num = (NUM *)malloc(sizeof(NUM));
    if(!num) {
        fprintf(stderr , "%s" , "Malloc error for int_to_NUM\n");
    }
    num->storedVal.ival = numInput;
    return num;
}


NUM* float_to_NUM(float floatInput) {
    NUM *num = (NUM *)malloc(sizeof(NUM));
    if(!num) {
        fprintf(stderr , "%s" , "Malloc error for float_to_NUM\n");

    }
    num->storedVal.fval = floatInput;
    return num;
}

int main() {
    yyin = stdin;

    do {
        yyparse();
    } while (!feof(yyin));

    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr , "Parse error: %s\n" , s);
    exit(1);
}