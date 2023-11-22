%{
#include "analyzer.tab.h"
int currentLine=1;

#include <string.h>
#include <stdlib.h>

void addToFIP(char atom[], int codAtom,int codTS)
{
}

int addToTS(char atom[])
{
	return 0;
}
void printTS()
{
}

void printFIP()
{
}
%}

%option noyywrap

REAL_NUMBER  -?([0-9]+|[0-9]*\.[0-9]+([eE][-+]?[0-9]+)?)
ID [a-z][a-z_]*
SUFIX   ((u|U)?(l|L)?(l|L)?)|((l|L)?(l|L)?(u|U)?)
BINAR   (0b|0B)(0|1)+{SUFIX}
OCTA    0[0-7]*{SUFIX}
HEXA    0(x|X)[0-9A-Ea-e]+{SUFIX}

%%
if              { addToFIP(yytext, 2, -1); printf("%s added to fip \n", yytext); return IF; }
else            { addToFIP(yytext, 3, -1);printf("%s is simbol \n", yytext); return ELSE; }
while           { addToFIP(yytext, 4, -1); printf("%s is simbol \n", yytext); return WHILE;  }
"/"             { addToFIP(yytext,27,-1); printf("%s is simbol \n", yytext); return DIVID;  }
"<"             { addToFIP(yytext,31,-1); printf("%s is simbol \n", yytext); return LT;   }
">"             { addToFIP(yytext,32,-1); printf("%s is simbol \n", yytext); return GT;  }
"("|")"         { addToFIP(yytext,33,-1); printf("%s is simbol \n", yytext); return PARAN; }
"{"|"}"         { addToFIP(yytext,34,-1); printf("%s is simbol \n", yytext); return BRACE; }
"["|"]"         { addToFIP(yytext,35,-1); printf("%s is simbol \n", yytext); return SQUARE; }
":"             { addToFIP(yytext,36,-1); printf("%s is simbol \n", yytext); return COLON; }
";"             { addToFIP(yytext,37,-1); printf("%s is simbol \n", yytext); return SEMICOLON; }
","             { addToFIP(yytext,38,-1); printf("%s is simbol \n", yytext); return COMMA; }
"."             { addToFIP(yytext,39,-1); printf("%s is simbol \n", yytext); return PERIOD; printf("%s is simbol \n", yytext); }
"="             { addToFIP(yytext,40,-1); printf("%s is simbol \n", yytext); return ASSIGN; printf("%s is simbol \n", yytext); }
"+"             { addToFIP(yytext,41,-1); printf("%s is simbol \n", yytext); return PLUS; printf("%s is simbol \n", yytext); }
"-"             { addToFIP(yytext,42,-1); printf("%s is simbol \n", yytext); return MINUS; printf("%s is simbol \n", yytext); }
"*"             { addToFIP(yytext,43,-1); printf("%s is simbol \n", yytext); return MUL; printf("%s is simbol \n", yytext); }
"!="            { addToFIP(yytext,44,-1); printf("%s is simbol \n", yytext); return NE; printf("%s is simbol \n", yytext); }
"=="            { addToFIP(yytext,45,-1); printf("%s is simbol \n", yytext); return EQ; printf("%s is simbol \n", yytext); }


{ID}{0,255}     {
                return ID;
}
{REAL_NUMBER}|{BINAR}|{OCTA}|{HEXA}     {
                        return CONSTANT;
}
[\n]            { currentLine++; }

[ \t]+ ;

%%