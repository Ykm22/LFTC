/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_ANALYZER_TAB_H_INCLUDED
# define YY_YY_ANALYZER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    CONSTANT = 258,                /* CONSTANT  */
    ID = 259,                      /* ID  */
    IF = 260,                      /* IF  */
    ELSE = 261,                    /* ELSE  */
    WHILE = 262,                   /* WHILE  */
    PERIOD = 263,                  /* PERIOD  */
    SEMICOLON = 264,               /* SEMICOLON  */
    COMMA = 265,                   /* COMMA  */
    COLON = 266,                   /* COLON  */
    PLUS = 267,                    /* PLUS  */
    MINUS = 268,                   /* MINUS  */
    MUL = 269,                     /* MUL  */
    MOD = 270,                     /* MOD  */
    DIVID = 271,                   /* DIVID  */
    ASSIGN = 272,                  /* ASSIGN  */
    LT = 273,                      /* LT  */
    GT = 274,                      /* GT  */
    NE = 275,                      /* NE  */
    BRACE = 276,                   /* BRACE  */
    PARAN = 277,                   /* PARAN  */
    SQUARE = 278,                  /* SQUARE  */
    JAVAUTIL = 279,                /* JAVAUTIL  */
    EQ = 280,                      /* EQ  */
    INCLUDE = 281,                 /* INCLUDE  */
    USING = 282,                   /* USING  */
    ANTHET = 283,                  /* ANTHET  */
    OPENED_BRACE = 284,            /* OPENED_BRACE  */
    CLOSED_BRACE = 285,            /* CLOSED_BRACE  */
    INT = 286,                     /* INT  */
    FLOAT = 287,                   /* FLOAT  */
    IN_OPERATOR = 288,             /* IN_OPERATOR  */
    OUT_OPERATOR = 289,            /* OUT_OPERATOR  */
    STRING = 290,                  /* STRING  */
    CIN = 291,                     /* CIN  */
    COUT = 292,                    /* COUT  */
    RETURN = 293,                  /* RETURN  */
    OPENED_PARAN = 294,            /* OPENED_PARAN  */
    CLOSED_PARAN = 295             /* CLOSED_PARAN  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 16 "analyzer.y"

    char* str;

#line 108 "analyzer.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_ANALYZER_TAB_H_INCLUDED  */
