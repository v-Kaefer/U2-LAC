// LINGUAGEM BARE BONES
grammar BareBones;

exprsBB: exprBB? EOF;

exprBB: 
    | exprBB ('*' | '/') exprBB
    | exprBB ('+' | '-') exprBB // Operadores de menor prioridade
    | NUMEROBB
    | '(' exprBB ')' // Uma expressão, pode ser outra expressão. Separada por (). 
    // Comandos 'clear', 'incr', 'decr' com identificador de variável (ID_VAR)
    | 'clear' ID_VAR
    | 'incr' ID_VAR
    | 'decr' ID_VAR
    ;

// Regras Léxicas - BARE BONES
//Regra 1: Identificador de Variáveis
ID_VAR: LETRA(NUMEROBB)+ | SUBLINHADO;
LETRA: [a-zA-Z];
SUBLINHADO: LETRA'_'[2-9]+[0-9]?; // De qualquer tamanho maior que 1

//Regra 2: Valores Literais [00, 01 => Inválidos]
ZERO: '0';
NUMEROBB: [1-9]+[0-9]?;


//ETC
BRANCO: [ \t\r\n]+ -> skip;


/*INPUTS PARA TESTES
clear x
incr x
decr x