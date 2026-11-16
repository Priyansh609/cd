
%{
#include <stdio.h>
%}

%option noyywrap

%%
"int"|"float"|"char"|"if"|"else"|"while"  { printf("Keyword: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*                   { printf("Identifier: %s\n", yytext); }
[0-9]+                                   { printf("Number: %s\n", yytext); }
[+\-*/=<>]                               { printf("Operator: %s\n", yytext); }
[;(),{}]                                 { printf("Symbol: %s\n", yytext); }
[ \t\n]+                                 ;
.                                        { printf("Invalid: %s\n", yytext); }
%%

int main() {
    printf("Enter code:\n");
    yylex();
    return 0;
}

flex practical1.l
gcc lex.yy.c -o practical1
./practical1