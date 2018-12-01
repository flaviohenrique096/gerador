%option noyywrap

%x COMENTARIO

%{
#include<string.h>
#include<stdio.h>
#include<stdlib.h>
#include <sintatico.tab.h>
int coluna = 1; 
int lines = 1;
int lines2 = 0;
int chars2 = 1;
%}

%%
"void"     {coluna+=strlen(yytext); return VOID;}
"int"      {coluna+=strlen(yytext); return INT;}
"char"     {coluna+=strlen(yytext); return CHAR;}
"return"   {coluna+=strlen(yytext); return RETURN;}
"break"    {coluna+=strlen(yytext); return BREAK;}
"switch"   {coluna+=strlen(yytext); return SWITCH;}
"case"     {coluna+=strlen(yytext); return CASE;}
"default"  {coluna+=strlen(yytext); return DEFAULT;}
"do"       {coluna+=strlen(yytext); return DO;}
"while"    {coluna+=strlen(yytext); return WHILE;}
"for"      {coluna+=strlen(yytext); return FOR;}
"if"       {coluna+=strlen(yytext); return IF;}
"else"     {coluna+=strlen(yytext); return ELSE;}
"typedef"  {coluna+=strlen(yytext); return TYPEDEF;}
"struct"   {coluna+=strlen(yytext); return STRUCT;}
"+"        {coluna+=strlen(yytext); return PLUS;}
"-"        {coluna+=strlen(yytext); return MINUS;}
"*"        {coluna+=strlen(yytext); return MULTIPLY;}
"/"        {coluna+=strlen(yytext); return DIV;}
"%"        {coluna+=strlen(yytext); return REMAINDER;}
"++"       {coluna+=strlen(yytext); return INC;}
"--"       {coluna+=strlen(yytext); return DEC;}
"&"        {coluna+=strlen(yytext); return BITWISE_AND;}
"|"        {coluna+=strlen(yytext); return BITWISE_OR;}
"~"        {coluna+=strlen(yytext); return BITWISE_NOT;}
"^"        {coluna+=strlen(yytext); return BITWISE_XOR;}
"!"        {coluna+=strlen(yytext); return NOT;}
"&&"       {coluna+=strlen(yytext); return LOGICAL_AND;}
"||"       {coluna+=strlen(yytext); return LOGICAL_OR;}
"=="       {coluna+=strlen(yytext); return EQUAL;}
"!="       {coluna+=strlen(yytext); return NOT_EQUAL;}
"<"  	   {coluna+=strlen(yytext); return LESS_THAN;}
">"	   {coluna+=strlen(yytext); return GREATER_THAN;}
"<="       {coluna+=strlen(yytext); return LESS_EQUAL;}
">="       {coluna+=strlen(yytext); return GREATER_EQUAL;}
"<<"       {coluna+=strlen(yytext); return L_SHIFT;}
">>"       {coluna+=strlen(yytext); return R_SHIFT;}
"="        {coluna+=strlen(yytext); return ASSIGN;}
"+="       {coluna+=strlen(yytext); return ADD_ASSIGN;}
"-="       {coluna+=strlen(yytext); return MINUS_ASSIGN;}
";"        {coluna+=strlen(yytext); return SEMICOLON;}
","        {coluna+=strlen(yytext); return COMMA;}
":"        {coluna+=strlen(yytext); return COLON;}
"("        {coluna+=strlen(yytext); return L_PAREN;}
")"        {coluna+=strlen(yytext); return R_PAREN;}
"{"        {coluna+=strlen(yytext); return L_CURLY_BRACKET;}
"}"        {coluna+=strlen(yytext); return R_CURLY_BRACKET;}
"["        {coluna+=strlen(yytext); return L_SQUARE_BRACKET;}
"]"        {coluna+=strlen(yytext); return R_SQUARE_BRACKET;}
"?"        {coluna+=strlen(yytext); return TERNARY_CONDITIONAL;}
"#"        {coluna+=strlen(yytext); return NUMBER_SIGN;}
"->"       {coluna+=strlen(yytext); return POINTER;}
"printf"   {coluna+=strlen(yytext); return PRINTF;}
"scanf"    {coluna+=strlen(yytext); return SCANF;}
"define"   {coluna+=strlen(yytext); return DEFINE;}
"exit"     {coluna+=strlen(yytext); return EXIT;}
0[1-7][0-7]*    {coluna+= strlen(yytext); return NUM_OCTAL;}
[0-9]+         	{coluna+= strlen(yytext); return NUM_INTEGER ; }
0[Xx][0-9a-fA-F]+ 	{coluna+= strlen(yytext); return NUM_HEXA; }
'[\\]?(.)'	{coluna+= strlen(yytext); return CHARACTER ;}
\"([^\\\"]|\\.)*\"	{coluna+= strlen(yytext); return STRING ;}
[_a-zA-Z][_a-zA-Z0-9]*	{coluna+= strlen(yytext); return IDENTIFIER ;}
" "			{ coluna+= strlen(yytext);}
"\t"        		{ coluna+= strlen(yytext); }   
"//"(.)*"\n"		{ lines++; coluna=1;  yylineno++;}
"\n"			{ lines++; coluna=1;  yylineno++;}
<INITIAL>{
     "/*"  {lines2 = lines; chars2 = coluna; coluna+=2;}  BEGIN(COMENTARIO);
     }

<COMENTARIO>{
     <<EOF>>   {printf("error:lexical:%d:%d: unterminated comment",lines2,chars2); exit(0);} BEGIN(INITIAL);
     "*/"      { coluna+=2; } BEGIN(INITIAL);
     [^*\n]+   { coluna+= strlen(yytext);}
     "*"       { coluna+= strlen(yytext);}
     \n        {yylineno++; lines++; coluna = 1;}
     }
\/\/([^\n])*  { coluna += strlen(yytext);}
.       {
		printf("error:lexical:%d:%d: %s",lines,coluna,yytext); 
		exit(0);
	}
%%
