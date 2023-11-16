/*** Definition Section ***/
%{
#include <string.h>
#include "SymbolTableIDS.h"
#include "SymbolTableCONSTS.h"

int errorFound = 0;
int lineNumber = 1;


typedef struct{
	char atom[100];
	int codAtom;
	int codTS;
}FIP;

typedef struct{
	char atom[100];
	int codAtomTS;
}TS;

FIP fip[300];
TS ts[300];
int codTS = 0;

// Init SymbolTables
// IDS
SymbolTableIDS tableIDS;

// test
// printf("inserting into tableIDS\n");
// insertID(&tableIDS, "test", 10);
// int value = findID(&tableIDS, "test");
// printf("after insert found: %d\n", &value);

// CONSTS
SymbolTableCONSTS tableCONSTS;

void addToFIP(char atom[], int codAtom, int codTS) {

}

int addToTSCONSTS(const char *name) {
    // printf("added %s to consts\n", name);
	return insertCONST(&tableCONSTS, name);
}

int addToTSIDS(const char* name) {
    // printf("added %s to ids\n", name);
    return insertID(&tableIDS, name);
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

void printFIP() {}


%}

INT_NUMBER    [+-]?[0-9]+
HEXA_NUMBER   0[xX][0-9a-fA-F]+
BINARY_NUMBER 0[bB][01]+
OCTAL_NUMBER  0[oO]?[0-7]+
FLOAT_NUMBER  [+-]?([0-9]*[.])?[0-9]+([eE][+-]?[0-9]+)?

IDENTIFIER    [A-Za-z][A-Za-z0-9]{0,7}
STRING        \".*\"

/*** Rule Section ***/
%%
					/* yytext is the text in the buffer */
"#include <iostream>"					{ printf("%s - cod ATOM: %d \n", yytext, 30); }
"using namespace std"                   { printf("%s - cod ATOM: %d \n", yytext, 31); }
main                                    { printf("%s - cod ATOM: %d \n", yytext, 35); }
if                                    	{ printf("%s - cod ATOM: %d \n", yytext, 29); }
while                                   { printf("%s - cod ATOM: %d \n", yytext, 2); }
for                                    	{ printf("%s - cod ATOM: %d \n", yytext, 3); }
write                                   { printf("%s - cod ATOM: %d \n", yytext, 4); }
read                                    { printf("%s - cod ATOM: %d \n", yytext, 5); }
else                                    { printf("%s - cod ATOM: %d \n", yytext, 6); }
int                                    	{ printf("%s - cod ATOM: %d \n", yytext, 7); }
real                                   	{ printf("%s - cod ATOM: %d \n", yytext, 8); }
char									{ printf("%s - cod ATOM: %d \n", yytext, 9); }
\<                                    	{ printf("%s - cod ATOM: %d \n", yytext, 21); }
\<{2}									{ printf("%s - cod ATOM: %d \n", yytext, 10); }
\;                                    	{ printf("%s - cod ATOM: %d \n", yytext, 11); }
\(                                    	{ printf("%s - cod ATOM: %d \n", yytext, 12); }
\)                                    	{ printf("%s - cod ATOM: %d \n", yytext, 13); }
\,                                    	{ printf("%s - cod ATOM: %d \n", yytext, 14); }
\+                                    	{ printf("%s - cod ATOM: %d \n", yytext, 15); }
\-                                    	{ printf("%s - cod ATOM: %d \n", yytext, 16); }
\*                                    	{ printf("%s - cod ATOM: %d \n", yytext, 17); }
\/                                    	{ printf("%s - cod ATOM: %d \n", yytext, 18); }
\%                                    	{ printf("%s - cod ATOM: %d \n", yytext, 19); }
\>                                    	{ printf("%s - cod ATOM: %d \n", yytext, 20); }
\>=                                    	{ printf("%s - cod ATOM: %d \n", yytext, 22); }
\=                                    	{ printf("%s - cod ATOM: %d \n", yytext, 23); }
\==                                    	{ printf("%s - cod ATOM: %d \n", yytext, 24); }
\and                                    { printf("%s - cod ATOM: %d \n", yytext, 25); }
\or                                    	{ printf("%s - cod ATOM: %d \n", yytext, 26); }
\.                                    	{ printf("%s - cod ATOM: %d \n", yytext, 27); }
\!=                                    	{ printf("%s - cod ATOM: %d \n", yytext, 28); }
\{                                      { printf("%s - cod ATOM: %d \n", yytext, 32); }
\}                                      { printf("%s - cod ATOM: %d \n", yytext, 33); }
\;                                      { printf("%s - cod ATOM %d \n", yytext, 34); }
[\n]									{ ++lineNumber; }
{IDENTIFIER}							{ addToTSIDS(yytext); }
{INT_NUMBER}                            { addToTSCONSTS(yytext); }
{HEXA_NUMBER}                           { addToTSCONSTS(yytext); }
{BINARY_NUMBER}                         { addToTSCONSTS(yytext); }
{OCTAL_NUMBER}                          { addToTSCONSTS(yytext); }
{FLOAT_NUMBER}                          { addToTSCONSTS(yytext); }
{STRING}								{ printf("%s - CONST \n",yytext); }
[ \t\n]+             					{ ; /* eat up whitespace */ }
<<EOF>>									{ printFIP(); printTS(); cleanup(); return 0; }
.                						{ errorFound = 1; printf("Illegal token %sat line %d !", yytext, lineNumber); printf("\n"); }
%%

/* yywrap() - wraps the above rule section */
int yywrap() {}

int main(int argc, char** argv) {

	FILE *fp;
	fp = fopen(argv[1], "r");
	
	/* yyin - takes the file pointer which contains the input*/
	yyin = fp;
    
    initializeSymbolTableIDS(&tableIDS);
    initializeSymbolTableCONSTS(&tableCONSTS);


	/* yylex() - this is the main flex function which runs the Rule Section*/ 
	// check for EOF with != 0
	while( yylex() != 0) {}

	fclose(fp);
    
    simplePrintIDS();
    simplePrintCONSTS();

	return 0;
}