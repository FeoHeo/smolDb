%{
    #include <stdio.h>
    #include <math.h>
    int yylex (void);
    void yyerror (char const *);

%}

%define api.value.type {double}
%token NUM

%left '+' '-'   // Left will execute from left -> right
%left '*' '/'   // So that parser will calculate * and / first

%%
    input: 
        %empty
    | input line
    ;

    line: 
        '\n'
    | exp '\n'  {printf("%.10g\n" , $1);}
    ;

    exp:
     NUM
    |   exp exp '+' {$$ = $1 + $2;}
    |   exp exp '-' {$$ = $1 - $2;}
    |   exp exp '*' {$$ = $1 * $2;}
    |   exp exp '/' {$$ = $1 / $2;}
%%

#include <ctype.h>
#include <stdlib.h>

int yylex (void) {
    int c = getchar ();
    while (c == ' ' || c == '\t') {
        c = getchar ();
    }   // Skip whitespace and tabs

    if (c == '.' || isdigits(c))
}