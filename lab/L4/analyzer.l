%{
#include "analyzer.tab.h"

#include <string.h>
#include <stdlib.h>
#include "SymbolTableIDS.h"
#include "SymbolTableCONSTS.h"
#include <stdbool.h>

int errorFound = 0;
int currentLine = 1;

typedef struct FIP{
	char atom[100];
	int codAtom;
	int codTS;
}FIP;

// Init FIP
const int MAX_FIP_SIZE = 300;
FIP fip[300];
int fip_size = 0;

// Init SymbolTables
// IDS
SymbolTableIDS tableIDS;

void initializeSymbolTableIDS()
{
    tableIDS.size = TABLE_SIZE;
    for (int i = 0; i < TABLE_SIZE; i++)
    {
        tableIDS.symbols[i] = NULL;
    }
}

// CONSTS
SymbolTableCONSTS tableCONSTS;

void initializeSymbolTableCONSTS()
{
    tableCONSTS.size = TABLE_SIZE;
    printf("Initiated consts with table_size = %d\n", tableCONSTS.size);
    for (int i = 0; i < TABLE_SIZE; i++)
    {
        tableCONSTS.symbols[i] = NULL;
    }
}

void addToFIP(const char* atom, int codAtom,int codTS){
    if(fip_size >= MAX_FIP_SIZE) {
        printf("Reached maximum fip size: %d\n", MAX_FIP_SIZE);
        exit(1);
    }
    bool exists_already = 0;
    for(int i = 0; i < fip_size && exists_already == 0; i++) {
        const char* current_atom = fip[i].atom;
        if(strcmp(current_atom, atom) == 0) {
            exists_already = 1;
        }
    }
    if(!exists_already) {
        strcpy(fip[fip_size].atom, atom);
        fip[fip_size].codAtom = codAtom;
        fip[fip_size].codTS = codTS;

        fip_size++; 
    }
}

int addToTSCONSTS(const char *name) {
    printf("table consts size = %d\n", tableCONSTS.size);
	int codTS = insertCONST(&tableCONSTS, name);
    printf("added %s to consts\n", name);
    printf("table consts size = %d\n", tableCONSTS.size);
    addToFIP(name, 1, codTS);
    return codTS;
}

int addToTSIDS(const char* name) {
    // printf("added %s to ids\n", name);
    int codTS = insertID(&tableIDS, name);
    addToFIP(name, 0, codTS);
    return codTS;
}

void printTS() {
    printf("ID SymbolTable ------------------- \n");
    printIDS(&tableIDS);
    printf("\nCONSTS SymbolTable -------------------\n");
    printCONSTS(&tableCONSTS);
}

void cleanup() {
    cleanupCONSTS(&tableCONSTS);
    cleanupIDS(&tableIDS);
}

void printFIP() {
    printf("FIP -----------\n");
    for(int i = 0; i < fip_size; i++) {
        FIP current_atom = fip[i];
        printf("atom = %s --- cod atom = %d --- cod TS = %d\n", current_atom.atom, current_atom.codAtom, current_atom.codTS);
    }
    printf("\n");
}
%}

%option noyywrap

IDENTIFIER    [A-Za-z][A-Za-z0-9]{0,7}
ILLEGAL_ID    [A-Za-z0-9]{9,}

INT_NUMBER    [+-]?[0-9]+
HEXA_NUMBER   0[xX][0-9a-fA-F]+
BINARY_NUMBER 0[bB][01]+
OCTAL_NUMBER  0[oO]?[0-7]+
FLOAT_NUMBER  [+-]?([0-9]*[.])?[0-9]+([eE][+-]?[0-9]+)?


%%
if              { addToFIP(yytext, 2, -1); printf("%s added to fip \n", yytext); return IF; }
else            { addToFIP(yytext, 3, -1); printf("%s is simbol \n", yytext); return ELSE; }
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
"."             { addToFIP(yytext,39,-1); printf("%s is simbol \n", yytext); return PERIOD; }
"="             { addToFIP(yytext,40,-1); printf("%s is simbol \n", yytext); return ASSIGN; }
"+"             { addToFIP(yytext,41,-1); printf("%s is simbol \n", yytext); return PLUS; }
"-"             { addToFIP(yytext,42,-1); printf("%s is simbol \n", yytext); return MINUS; }
"*"             { addToFIP(yytext,43,-1); printf("%s is simbol \n", yytext); return MUL; }
"!="            { addToFIP(yytext,44,-1); printf("%s is simbol \n", yytext); return NE; }
"=="            { addToFIP(yytext,45,-1); printf("%s is simbol \n", yytext); return EQ; }


{IDENTIFIER}    { addToTSIDS(yytext); return ID;}
{INT_NUMBER}|{HEXA_NUMBER}|{BINARY_NUMBER}|{OCTAL_NUMBER}|{FLOAT_NUMBER} { addToTSCONSTS(yytext); return CONSTANT;}
[\n]            { currentLine++; }

[ \t]+ ;
%%