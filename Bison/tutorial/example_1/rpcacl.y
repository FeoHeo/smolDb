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

    if (c == '.' || isdigit(c)) {
        ungetc(c , stdin);
        if(scanf("%lf" , &yylval) != 1) { // yylval stores the value of token before passing to parser
            abort();
        } 
        return NUM;
    } else if(c == EOF) {   // Return end of input
        return YYEOF;
    } else {
        return c;
    }
}

int main (void)     // controllling function, this is currently kept to bare minimum
{
  return yyparse ();
}



#include <stdio.h>

/* Called by yyparse on error. */
void
yyerror (char const *s)
{
  fprintf (stderr, "%s\n", s);
}
