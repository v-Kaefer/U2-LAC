# U2-LAC
Unidade Avaliativa 2 | Avaliação de Aprendizagem

Extensão VSCode para ANTLR: [ANTLR4 grammar syntax support](https://marketplace.visualstudio.com/items?itemName=mike-lischke.vscode-antlr4)

Definições Extras:

# Componentes de uma Definição de Regra (EBNF)
## Definições Sintáticas
#### Sequência de símbolos:
    Uma regra pode ser definida como uma sequência de outros símbolos ou tokens.

    regra : elemento1 elemento2 elemento3;

### Escolha (alternativas): 
    Para opções alternativas, usamos o símbolo |.

    regra : elemento1 | elemento2 | elemento3;

### Repetições:
    Para indicar que um elemento pode se repetir zero ou mais vezes, usamos o operador *. Para uma ou mais vezes, usamos +.

    regra : elemento*;
    regra : elemento+;

### Opcionalidade:
    Para indicar que um elemento é opcional, usamos o operador ?.

    regra : elemento?;

## Regras Léxicas
### Definição de tokens:
    Tokens básicos podem ser definidos como cadeias de caracteres ou expressões regulares. 

    ID : [a-zA-Z]+ ;   // identificadores (um ou mais caracteres alfabéticos)
    INT : [0-9]+ ;     // números inteiros (um ou mais dígitos)

### Ignorar caracteres:
    É comum ignorar espaços em branco, quebras de linha ou comentários na gramática.

    WS : [ \t\r\n]+ -> skip ;   // espaços em branco são ignorados

## Exemplo Completo de uma Gramática Simples em ANTLR

grammar Exemplo;

// Regras sintáticas
prog : stmt+ ;                // Um ou mais comandos

stmt : expr ';'               // Comando é uma expressão seguida de ';'
     | 'if' expr 'then' stmt  // Comando condicional
     | 'while' expr 'do' stmt // Comando de repetição
     ;

// Regras de expressão
expr : expr ('+' | '-') term   // Expressões com soma e subtração
     | term
     ;

term : term ('*' | '/') factor // Termos com multiplicação e divisão
     | factor
     ;

factor : '(' expr ')'          // Sub-expressão entre parênteses
       | INT                   // Número inteiro
       ;

// Regras léxicas
INT : [0-9]+ ;                 // Números inteiros
WS : [ \t\r\n]+ -> skip ;      // Ignora espaços em branco
