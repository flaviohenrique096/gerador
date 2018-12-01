%{
#include <stdio.h>
#include<string.h>
#include<stdlib.h>
extern int yylex();
extern char* yytext;
extern int coluna;
extern int lines;
char *entrada ;
int qtdCharsArquivo = 0 ;
int totalColuna = 1 ; 
int totalLinha = 1 ;
%}

%token ELSE
%token TYPEDEF
%token STRUCT
%token PLUS
%token MINUS
%token MULTIPLY
%token DIV
%token REMAINDER
%token INC
%token DEC
%token BITWISE_AND
%token BITWISE_OR
%token BITWISE_NOT
%token BITWISE_XOR
%token NOT
%token LOGICAL_AND
%token LOGICAL_OR
%token EQUAL
%token NOT_EQUAL
%token LESS_THAN
%token GREATER_THAN
%token LESS_EQUAL
%token GREATER_EQUAL
%token R_SHIFT
%token L_SHIFT
%token ASSIGN
%token VOID
%token INT
%token CHAR
%token RETURN
%token BREAK
%token SWITCH
%token CASE
%token DEFAULT
%token DO
%token WHILE
%token FOR
%token IF
%token ADD_ASSIGN
%token MINUS_ASSIGN
%token SEMICOLON
%token COMMA
%token COLON
%token L_PAREN
%token R_PAREN
%token L_CURLY_BRACKET
%token R_CURLY_BRACKET
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token TERNARY_CONDITIONAL
%token NUMBER_SIGN
%token POINTER
%token PRINTF
%token SCANF
%token DEFINE
%token EXIT
%token NUM_OCTAL
%token NUM_INTEGER
%token NUM_HEXA
%token CHARACTER
%token STRING
%token IDENTIFIER

%start S

%%

S: programa
;
	
programa: declaracoes programa1
	| funcao programa1
;

programa1: programa
	|
;

declaracoes: NUMBER_SIGN DEFINE IDENTIFIER expressao
	| declaracao_variaveis
	| declaracao_prototipos
;

funcao: tipo funcao1
;

funcao1: MULTIPLY funcao1
	| IDENTIFIER parametros L_CURLY_BRACKET funcao2
;

funcao2: declaracao_variaveis funcao2
	| comandos R_CURLY_BRACKET
;

declaracao_variaveis: tipo declaracao_variaveis1
;

declaracao_variaveis1: MULTIPLY declaracao_variaveis1
	| IDENTIFIER declaracao_variaveis2
;

declaracao_variaveis2: L_SQUARE_BRACKET expressao R_SQUARE_BRACKET declaracao_variaveis2
	| declaracao_variaveis3
	| ASSIGN expressao_atribuicao declaracao_variaveis3
;

declaracao_variaveis3: SEMICOLON
	| COMMA declaracao_variaveis1 
;

declaracao_prototipos: tipo declaracao_prototipos1
;

declaracao_prototipos1: MULTIPLY declaracao_prototipos1
	| IDENTIFIER parametros SEMICOLON
;

parametros: L_PAREN parametros1
;

parametros1: R_PAREN
	| parametros2
;

parametros2: tipo parametros3
;

parametros3: MULTIPLY parametros3
	| IDENTIFIER parametros4
;

parametros4: L_SQUARE_BRACKET expressao R_SQUARE_BRACKET parametros4
	| COMMA parametros2
	| R_PAREN
;

tipo: INT
	| CHAR
	| VOID
;

bloco: L_CURLY_BRACKET comandos R_CURLY_BRACKET
;

comandos: lista_comandos comandos1
;

comandos1: comandos
	|
;

lista_comandos: DO bloco WHILE L_PAREN expressao R_PAREN SEMICOLON
	| IF L_PAREN expressao R_PAREN bloco lista_comandos1
	| WHILE L_PAREN expressao R_PAREN bloco
	| FOR L_PAREN lista_comandos2
	| PRINTF L_PAREN STRING lista_comandos6
	| SCANF L_PAREN STRING COMMA BITWISE_AND IDENTIFIER R_PAREN SEMICOLON
	| EXIT L_PAREN expressao R_PAREN SEMICOLON
	| RETURN lista_comandos7
	| expressao SEMICOLON
	| SEMICOLON
	| bloco
;

lista_comandos1: ELSE bloco
	|
;
	
lista_comandos2: expressao SEMICOLON lista_comandos3
	| SEMICOLON lista_comandos3
;

lista_comandos3: expressao SEMICOLON lista_comandos4
	| SEMICOLON lista_comandos4
;

lista_comandos4: expressao lista_comandos5
	| lista_comandos5
;

lista_comandos5: R_PAREN bloco
;

lista_comandos6: COMMA expressao R_PAREN SEMICOLON
	| R_PAREN SEMICOLON
;

lista_comandos7: expressao SEMICOLON
	| SEMICOLON
;

expressao: expressao_atribuicao expressao1
;

expressao1: COMMA expressao_atribuicao expressao1
	|
;

expressao_atribuicao: expressao_condicional
	| expressao_unaria expressao_atribuicao1
;

expressao_atribuicao1: ASSIGN expressao_atribuicao
	| ADD_ASSIGN expressao_atribuicao
	| MINUS_ASSIGN expressao_atribuicao
;

expressao_condicional: expressao_or_logico expressao_condicional1
;

expressao_condicional1: TERNARY_CONDITIONAL expressao COLON expressao_condicional
	| 
;

expressao_or_logico: expressao_and_logico expressao_or_logico1
;

expressao_or_logico1: LOGICAL_OR expressao_and_logico expressao_or_logico1
	| 
;

expressao_and_logico: expressao_or expressao_and_logico1
;

expressao_and_logico1: LOGICAL_AND expressao_or expressao_and_logico1
	| 
;

expressao_or: expressao_xor expressao_or1
;

expressao_or1: BITWISE_OR expressao_xor expressao_or1
	| 
;

expressao_xor: expressao_and expressao_xor1
;

expressao_xor1: BITWISE_XOR expressao_and expressao_xor1
	| 
;

expressao_and: expressao_igualdade expressao_and1
;

expressao_and1: BITWISE_AND expressao_igualdade expressao_and1
	|
;

expressao_igualdade: expressao_relacional expressao_igualdade1
;

expressao_igualdade1: EQUAL expressao_relacional expressao_igualdade1
	| NOT_EQUAL expressao_relacional expressao_igualdade1
	|
;

expressao_relacional: expressao_shift expressao_relacional1
;

expressao_relacional1: LESS_THAN expressao_shift expressao_relacional1
	| GREATER_THAN expressao_shift expressao_relacional1
	| GREATER_EQUAL expressao_shift expressao_relacional1
	| LESS_EQUAL expressao_shift expressao_relacional1
	|
;

expressao_shift: expressao_aditiva expressao_shift1
;

expressao_shift1: L_SHIFT expressao_aditiva expressao_shift1
	| R_SHIFT expressao_aditiva expressao_shift1
	|
;

expressao_aditiva: expressao_multiplicativa expressao_aditiva1
;

expressao_aditiva1: MINUS expressao_multiplicativa expressao_aditiva1
	| PLUS expressao_multiplicativa expressao_aditiva1
	|
;

expressao_multiplicativa: expressao_cast expressao_multiplicativa1
;

expressao_multiplicativa1: MULTIPLY expressao_cast expressao_multiplicativa1
	| DIV expressao_cast expressao_multiplicativa1
	| REMAINDER expressao_cast expressao_multiplicativa1
	|
;

expressao_cast: expressao_unaria
	| L_PAREN tipo R_PAREN expressao_cast
;

expressao_unaria: expressao_pos_fixa
	| PLUS expressao_cast
	| MINUS expressao_cast
	| BITWISE_NOT expressao_cast
	| NOT expressao_cast
	| INC expressao_unaria
	| DEC expressao_unaria
	| BITWISE_AND expressao_cast
	| MULTIPLY expressao_cast
;

expressao_pos_fixa: expressao_primaria
	| expressao_pos_fixa expressao_pos_fixa1
;

expressao_pos_fixa1: L_SQUARE_BRACKET expressao R_SQUARE_BRACKET
	| INC
	| DEC
	| L_PAREN expressao_pos_fixa2
;

expressao_pos_fixa2: R_PAREN
	| expressao_pos_fixa3
;

expressao_pos_fixa3: expressao_atribuicao expressao_pos_fixa4
;

expressao_pos_fixa4: COMMA expressao_pos_fixa3 
	| R_PAREN
;

expressao_primaria: IDENTIFIER
	| numero
	| CHARACTER
	| STRING
	| L_PAREN expressao R_PAREN
;

numero: NUM_INTEGER
	| NUM_HEXA
	| NUM_OCTAL
;

%%

yyerror(char *s)
{   
	if (totalColuna == coluna && totalLinha == lines && strcmp(yytext,"") == 0)
	{
		int i = 0, cont = 1, contc = 1, f = -1, in, bloco = 0  ;
		char *stringSaida ; 
		while (i  < qtdCharsArquivo)
		{
			if (entrada[i] == '\n')
				cont++;
		
			if (cont == lines)
			{
				if (cont != 1)
					i++;
				in = i ;
				while (entrada[in]!='\n' && entrada[in] != '\0')
				{
					if (entrada[in]=='/'&&entrada[in+1]=='*')
						bloco = 1;
					if (entrada[in]=='/'&&entrada[in+1]=='/' && bloco == 0)
						f = contc ;
					in++;
					contc++;
				}
				stringSaida = calloc (contc + 1 , sizeof(char));
				int j ;
				in = i ;	
				for (j = 0; j < contc; j++)
				{
					stringSaida[j] = entrada[in] ;
					in++;
				}				

				if(f == -1) 
				{
					printf("error:syntax:%d:%d: expected declaration or statement at end of input\n",lines,coluna);
					printf("%s\n",stringSaida);
					for (j = 0 ; j < coluna - strlen(yytext) - 1 ; j++)
						printf(" ");
				}
				else
				{
					printf("error:syntax:%d:%d: expected declaration or statement at end of input\n",lines,f);
					printf("%s\n",stringSaida);
					for (j = 0 ; j < f - 1; j++)
						printf(" ");
				}				
				printf("^");
				exit(0); 
			}
			i++ ;		
		}
	}
	else
	{
		printf("error:syntax:%d:%d: %s\n",lines, coluna - strlen(yytext),yytext);	
		int i = 0, cont = 1;
		while (i  < qtdCharsArquivo)
		{
			if (entrada[i] == '\n')
				cont++;
			if (cont == lines)
			{
				if (cont != 1)
					i++; 
				while (entrada[i]!='\n' && entrada[i] != '\0')
				{
					printf("%c",entrada[i]); 
					i++;
				}
				printf("\n") ;
				int j ; 
				for (j = 0 ; j < coluna - strlen(yytext) - 1 ; j++)
					printf(" ");
				printf("^");
				exit(0); 
			}
			i++ ;		
		}
	}
}

int main(int argc, char **argv)
{ 
	char c;	 
    	while(fscanf(stdin,"%c",&c)!=EOF)	
		qtdCharsArquivo++ ; 
	entrada = calloc(qtdCharsArquivo + 1, sizeof(char));
	rewind(stdin) ;
	int i = 0 ;
	while(fscanf(stdin,"%c",&c)!=EOF)
	{
		entrada[i] = c ;			
		if (entrada[i] == '\n')
		{
			totalLinha++;
			totalColuna = 0 ; 
		}
		if (entrada[i] == '\t')
		{
			totalColuna += 3 ;
		}					
		i++ ;
		totalColuna++ ;   
	}
	rewind(stdin) ;	
	yyparse();
	printf("SUCCESSFUL COMPILATION.");
	return 0 ; 
}
