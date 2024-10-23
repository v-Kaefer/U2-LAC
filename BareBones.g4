// LINGUAGEM BARE BONES
grammar BareBones;

exprsBB: exprBB* EOF;

exprBB: exprBB ('*' | '/') exprBB
    | exprBB ('+' | '-') exprBB // Operadores de menor prioridade
    | NUMEROBB
    | '(' exprBB ')' // Uma expressão, pode ser outra expressão. Separada por (). 
    | clear
    | incr
    | decr
    ;


// Regras Léxicas - BARE BONES
//Regra 1: Identificador de Variáveis
ID_VAR: (LETRA((VAL_LIT)+(ZERO)?) | SUBLINHADO((SUBLI_NUMS)+(ZERO)?));
LETRA: [a-zA-Z];
SUBLINHADO: LETRA'_';
SUBLI_NUMS: [2-9]; // De qualquer tamanho maior que 1

//Regra 2: Valores Literais [00, 01 => Inválidos]
ZERO: '0';
VAL_LIT: NUMEROBB(ZERO)?;
NUMEROBB: [1-9]+;


//Regra 3: Operadores
clear: 'clear' ID_VAR {
    variables.put($ID_VAR.text, 0);
    System.out.println("Variável " + $ID_VAR.text + " recebeu o valor 0");
};

incr: 'incr' ID_VAR {
    variables.put($ID_VAR.text, variables.getOrDefault($ID_VAR.text, 0) + 1);
    System.out.println("Variável " + $ID_VAR.text + " recebeu o valor " + variables.get($ID_VAR.text));
};

decr: 'decr' ID_VAR {
    variables.put($ID_VAR.text, variables.getOrDefault($ID_VAR.text, 0) - 1);
    System.out.println("Variável " + $ID_VAR.text + " recebeu o valor " + variables.get($ID_VAR.text));
};


//ETC
BRANCO: [ \t\r\n]+ -> skip;