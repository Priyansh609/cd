
%{
#include <stdio.h>
%}

%option noyywrap

%%
"int"|"float"|"char"|"double"|"void"  { printf("Data Type: %s\n",yytext); }
[a-zA-Z_][a-zA-Z0-9_]*               { printf("Identifier: %s\n",yytext); }
[0-9]+\.[0-9]+                       { printf("Float: %s\n",yytext); }
[0-9]+                               { printf("Integer: %s\n",yytext); }
\'[^\']*\'                           { printf("Character: %s\n",yytext); }
\"[^\"]*\"                           { printf("String: %s\n",yytext); }
"//".*                               { printf("Comment: %s\n",yytext); }
"/*"([^*]|\*+[^*/])*\*+"/"           { printf("Comment: %s\n",yytext); }
"++"|"--"                             { printf("Increment: %s\n",yytext); }
"=="|"!="|"<="|">="|"<"|">"          { printf("Relational: %s\n",yytext); }
"="                                  { printf("Assignment: %s\n",yytext); }
"+"|"-"|"*"|"/"|"%"                  { printf("Arithmetic/Unary: %s\n",yytext); }
[;:{}()]                             { printf("Special Symbol: %s\n",yytext); }
[ \t\n]+                             ;
.                                    { printf("Invalid: %s\n",yytext); }
%%

int main() {
    printf("Enter code:\n");
    yylex();
    return 0;
}

flex practical2.l
gcc lex.yy.c -o practical2
./practical2