%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
void yyerror(char *);
#include "proj.tab.h"
%}
%%
[0-9]+ { yylval.num = atoi(yytext); return INTEGER; }
[0-9]+[.][0-9]+ { yylval.val = atof(yytext); return FLOAT; }
"exit" { return EXIT; }
[isequalshowmany] { return *yytext; }
"kilograms"|"kgs"|"kilogram"|"kg"|"grams"|"gram"|"milligrams"|"milligram"|"gms"|"gm"|"mgs"|"mg" { yylval.str = strdup(yytext); return UNIT; }
"?" { return EOS; }
[!\n] { return *yytext; }
[ |\t] { /* Ignoring Whitespace */ }
. { yyerror("Unrecognized Character\n"); }
%%

void main(){
 yyparse();
}

int yywrap(){}

void yyerror(char *s) {
 fprintf(stderr, "%s\n", s);
}

void convert(float value, char *unit1, char *unit2)
{
double newValue = value;
 if(strcmp(unit1, "kg") == 0 || strcmp(unit1, "kilogram") == 0 ||  strcmp(unit1, "kgs") == 0 || strcmp(unit1, "kilograms") == 0)
	{
		if(strcmp(unit2, "gram") == 0 || strcmp(unit2, "grams") == 0 || strcmp(unit2,"gms") == 0 || strcmp(unit2,"gm") == 0)
		{
			 newValue = value * 1000.0;
		}
		else if(strcmp(unit2, "mgs") == 0 || strcmp(unit2, "mg") == 0 || strcmp(unit2,"milligram") == 0 || strcmp(unit2,"milligrams") == 0)
		{
			newValue = value * 1000000.0;
		}
	}
 else if(strcmp(unit1, "gram") == 0 || strcmp(unit1, "grams") == 0 || strcmp(unit1,"gms") == 0 || strcmp(unit1,"gm") == 0)
	{
		if(strcmp(unit2, "kilogram") == 0 || strcmp(unit2, "kilograms") == 0 || strcmp(unit2,"kgs") == 0 || strcmp(unit2,"kg") == 0)
		{
			newValue = (value / 1000.0);
		}
		else if(strcmp(unit2, "milligram") == 0 || strcmp(unit2, "milligrams") == 0 || strcmp(unit2,"mgs") == 0 || strcmp(unit2,"mg") == 0)
		{
			newValue = (value * 1000.0);
		}
 
	}
 else if(strcmp(unit1, "milligrams") == 0 || strcmp(unit1, "milligram") == 0 || strcmp(unit1,"mgs") == 0 || strcmp(unit1,"mg") == 0)
	{
		if(strcmp(unit2, "kgs") == 0 || strcmp(unit2, "kilograms") == 0 || strcmp(unit2, "kg") == 0 || strcmp(unit2, "kilogram") == 0)
		{
			newValue = (double) value / 1000000.0;
		}
 
		else if(strcmp(unit2, "gram") == 0 || strcmp(unit2, "grams") == 0 || strcmp(unit2,"gms") == 0 || strcmp(unit2,"gm") == 0)
		{
			newValue = value / 1000.0 ;
		}
	}
	
printf("%.4f %s\n\n", newValue, unit2);
}