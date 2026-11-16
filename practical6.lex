
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char name[20][20];
int val[20], n=0;

void set(char *s,int v) {
    int i;
    for(i=0;i<n;i++)
        if(!strcmp(name[i],s)) break;
    strcpy(name[i],s);
    val[i]=v;
    if(i==n) n++;
}

int get(char *s) {
    for(int i=0;i<n;i++)
        if(!strcmp(name[i],s)) return val[i];
    return 0;
}

int yylex();
void yyerror(char *s) {}
%}

%union {
    int num;
    char *id;
}

%token <num> NUM
%token <id> ID
%type <num> expr

%left '+' '-'
%left '*' '/'

%%
input:
    | input line
    ;

line:
    ID '=' expr '\n' { set($1,$3); printf("%s = %d\n",$1,$3); }
    | expr '\n'      { printf("Result = %d\n",$1); }
    ;

expr:
    NUM             { $$=$1; }
    | ID            { $$=get($1); }
    | expr '+' expr { $$=$1+$3; }
    | expr '-' expr { $$=$1-$3; }
    | expr '*' expr { $$=$1*$3; }
    | expr '/' expr { $$=$1/$3; }
    | '(' expr ')'  { $$=$2; }
    ;
%%

int yylex() {
    int c;
    char s[100];
    while((c=getchar())==' ' || c=='\t');

    if(isdigit(c)) {
        ungetc(c,stdin);
        scanf("%d",&yylval.num);
        return NUM;
    }

    if(isalpha(c)) {
        int i=0;
        do {
            s[i++]=c;
            c=getchar();
        } while(isalnum(c));
        s[i]='\0';
        ungetc(c,stdin);
        yylval.id=strdup(s);
        return ID;
    }

    return c;
}

int main() {
    printf("Enter expressions:\n");
    yyparse();

    printf("\nSymbol Table:\n");
    for(int i=0;i<n;i++)
        printf("%s = %d\n",name[i],val[i]);

    return 0;
}

bison -d calc.y
gcc calc.tab.c -o calc
./calc