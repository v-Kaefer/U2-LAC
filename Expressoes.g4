grammar Expressoes;

// Regras sintáticas (parser): Descrevem a estrutura de frases ou sentenças válidas.
//  Elas começam com letras minúsculas e definem como os tokens devem ser organizados.
// * = pode ser repetida 0 ou + vezes
exprs: expr* EOF; //End Of File

// O que é uma expressão?   // terminal = ''    // opções = |
// Ex: expr: expressão aritmética com * ou /, seguido de outra expressão.

expr: expr ('*' | '/') expr
    | expr ('+' | '-') expr // Operadores de menor prioridade
    | NUMERO
    | '(' expr ')' // Uma expressão, pode ser outra expressão. Separada por ().
    ;

// Regras léxicas (lexer): Descrevem os tokens (símbolos) básicos, como números, identificadores ou operadores.
//  Elas sempre começam com letras maiúsculas.
// O que é NUMERO?
NUMERO: [0-9]+; // É uma escolha de 0 a 9, que pode ser repetido '+' = (1 ou +) vezes.

// Caracteres de tabulação. O que fazer?
// -> = Ação
BRANCO: [ \t\r\n]+ -> skip; // Ignora os espaços em branco, enter, nova linha, quebra linha.



// LINGUAGEM BARE BONES

exprsBB: exprBB* EOF;

exprBB: VAR ('' | '')


// Regras Léxicas - BARE BONES
//Regra 1: Identificador de Variáveis
VAR: LETRA | SUBLINHADO;
LETRA: [a-zA-Z];
SUBLI_NUMS: [2-9]; // De qualquer tamanho maior que 1
SUBLINHADO: LETRA'_'SUBLI_NUMS+;
//Regra 2: Valores Literais
ZERO: '0';
VAL_LIT: NUMEROBB | ZERO;
NUMEROBB: [1-9]+;