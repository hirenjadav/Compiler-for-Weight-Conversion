%{
 #include <stdio.h>
 #include <stdlib.h>
 #include <math.h>
 #include <string.h>
 int yylex(void);
 void yyerror(char *);
 void convert(float value, char *unit1, char *unit2 );
%}


%union{ int num; float val; char* str};
%token <num> INTEGER
%token <val> FLOAT
%token <str> UNIT
%token EOS
%token EXIT
%type <val> VALUE


%%
Program : Program Start {}
 |
 ;
Start : 'h''o''w''m''a''n''y' UNIT 'i''s' VALUE UNIT EOS '\n' 
 { convert( $11, $12, $8 ); }
 | VALUE UNIT 'e''q''u''a''l''s''h''o''w''m''a''n''y' UNIT EOS '\n' 
{ convert( $1, $2, $16 ); }
 | VALUE UNIT 'i''s' 'h''o''w' 'm''a''n''y' UNIT EOS '\n' 
{ convert( $1, $2, $12 ); }
 | EXIT { exit(0); }
 ;
VALUE : INTEGER { $$ = (float)$1; }
 | FLOAT {}
 ;
%%