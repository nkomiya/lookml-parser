lexer grammar LookMLLexer;

channels { COMMENT_CHANNEL }

// ======================================================================
// Special symbol
// ======================================================================
COLON: ':';
COMMA: ',';
PLUS: '+';
MINUS: '-';
LCURL: '{';
RCURL: '}';
LBRA: '[';
RBRA: ']';
STAR: '*';

// ======================================================================
// Keys for special properties
// ======================================================================
// sql
SQL: 'sql' [a-z_]* -> pushMode(SQL_MODE);
EXPRESSION: 'expression' -> pushMode(SQL_MODE);
EXPRESSION_CUSTOM_FILTER: 'expression_custom_filter' -> pushMode(SQL_MODE);
// html
HTML: 'html' -> pushMode(HTML_MODE);

// ======================================================================
// Literals
// ======================================================================
STRING_VALUE: '"' .*? '"';
INT_VALUE: [0-9]+;
YES: 'yes';
NO: 'no';

// ======================================================================
// Identifier
// ======================================================================
IDENT: [A-Za-z_] [A-Za-z0-9_.]*;
TIMEZONE_SLASH: [A-Za-z_] [A-Za-z0-9_-]* '/' [A-Za-z_] [A-Za-z0-9_-]*;

// ======================================================================
// Controls
// ======================================================================
COMMENT: '#' ~[\r\n]* (('\r'? '\n') | EOF) -> channel(COMMENT_CHANNEL);
WS: [ \t]+ -> channel(HIDDEN);
NL: ('\r' '\n'? | '\n') -> channel(HIDDEN);

// ======================================================================
// Multiline Script
// ======================================================================
mode SQL_MODE;
SQL_VALUE: ':' (
    (
        // inline comment
        (
            '--' ~[\r\n]* ('\r'? '\n')
        )
        // multiline comment
        | (
            '/*' .*? '*/'
        )
        // any
        | .
    )*?
) ';;' -> popMode;
SQL_WS_NL: ([ \t] | '\r' '\n'? | '\n');

mode HTML_MODE;
HTML_VALUE: ':' (
    (
        // multiline comment
        (
            '<!--' .*? '-->'
        )
        // any
        | .
    )*?
) ';;' -> popMode;
HTML_WS_NL: ([ \t] | '\r' '\n'? | '\n');
