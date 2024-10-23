// LINGUAGEM BARE BONES
grammar BareBones;

exprsBB: exprBB? EOF;

exprBB: exprBB ('*' | '/') exprBB
    | exprBB ('+' | '-') exprBB // Operadores de menor prioridade
    | NUMEROBB
    | '(' exprBB ')' // Uma expressão, pode ser outra expressão. Separada por (). 
    // Comandos 'clear', 'incr', 'decr' com identificador de variável (ID_VAR)
    | 'clear' ID_VAR ';'
    | 'incr' ID_VAR ';'
    | 'decr' ID_VAR ';'
    | move ';'
    | if
    | while
    | blocoComandos
    | progr
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
move: 'move' ID_VAR 'to' ID_VAR;

if: 'if' '(' ID_VAR ')' 'then' bloco 'else' bloco ';';

while: 'while' '(' ID_VAR ')' 'do' bloco ';';
bloco: exprBB+; // Um ou mais comandos, garantindo que não seja vazio

blocoComandos: 'begin' '(' exprBB? ')' 'end';

progr: 'progr' ID_VAR 'begin' exprBB* 'end';

//Terminador de Comandos [Condição não-funcional]
//Garantir o uso de ';', após todos os comandos, caso não termine por um bloco de comandos.
//-> Verificar enunciado de if, para esse condição.


/*INPUTS PARA TESTES
clear x1;
clear x_1;
clear x_9;
incr x2;
incr x_2;
incr x_10;
decr x3;
decr x_3;
decr x_30;
clear y_00;
incr y_01;
decr y_02;

move x1 to y1;
x_1 to y_1;
move x_1 to ;

if (x1) then clear y else incr z
if (x2) then incr y else decr z
if (x3) then clear y else decr z
if (x_2) then decr       // Deve falhar: falta um comando após 'then'
if (x_3) then            // Deve falhar: falta um comando após 'then' e 'else'
if (x_4)                 // Deve falhar: falta 'then' e 'else'
if (x_5) then clear y    // Deve falhar: falta um comando após 'else'

while (x1) do clear y
while (x2) do incr z
while (x3) do decr a clear b
while (x_2) do         // Deve falhar: falta um comando após 'do'
while (x_3)            // Deve falhar: falta 'do' e comandos

progr p1 begin end
progr p2 begin clear x end
progr p3 begin incr y; decr z end
progr p4 begin while (x) do incr y end
progr begin end      // Deve falhar: falta o nome do programa
progr p_2 end        // Deve falhar: falta 'begin'
progr p_3 begin      // Deve falhar: falta 'end'
