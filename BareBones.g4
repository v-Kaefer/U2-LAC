// LINGUAGEM BARE BONES
grammar BareBones;

exprsBB: exprBB? EOF;

exprBB: exprBB ('*' | '/') exprBB
    | exprBB ('+' | '-') exprBB // Operadores de menor prioridade
    | NUMEROBB
    | '(' exprBB ')' // Uma expressão, pode ser outra expressão. Separada por (). 
    // Comandos 'clear', 'incr', 'decr' com identificador de variável (ID_VAR)
    | 'clear' ID_VAR 
    | 'incr' ID_VAR
    | 'decr' ID_VAR
    | move
    | if
    | while
    ;

// Regras Léxicas - BARE BONES
//Regra 1: Identificador de Variáveis
ID_VAR: LETRA(NUMEROBB)+ | SUBLINHADO;
LETRA: [a-zA-Z];
SUBLINHADO: LETRA'_'[2-9]+[0-9]?; // De qualquer tamanho maior que 1

//Regra 2: Valores Literais [00, 01 => Inválidos]
NUMEROBB: [1-9]+[0-9]?;

//ETC
BRANCO: [ \t\r\n]+ -> skip;

//Comandos
move: ID_VAR 'to' ID_VAR;

if: 'if' '(' ID_VAR ')' 'then' bloco 'else' bloco;

while: 'while' '(' ID_VAR ')' 'do' bloco;
bloco: exprBB+; // Um ou mais comandos, garantindo que não seja vazio


/*INPUTS PARA TESTES
clear x1
clear x_1
clear x_9
incr x2
incr x_2
incr x_10
decr x3
decr x_3
decr x_30
clear y_00
incr y_01
decr y_02

move x to y

if (x) then clear y else incr z
if (x) then incr y else decr z
if (x) then clear y else decr z
if (x) then decr       // Deve falhar: falta um comando após 'then'
if (x) then            // Deve falhar: falta um comando após 'then' e 'else'
if (x)                 // Deve falhar: falta 'then' e 'else'
if (x) then clear y    // Deve falhar: falta um comando após 'else'

while (x) do clear y
while (x) do incr z
while (x) do decr a clear b
while (x) do         // Deve falhar: falta um comando após 'do'
while (x)            // Deve falhar: falta 'do' e comandos

