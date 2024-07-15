parser grammar LookMLParser;

options {
	tokenVocab = LookMLLexer;
}

root: definition* EOF;
definition
	: valueDefinition
	| sqlDefinition
	| htmlDefinition
	| blockDefinition
	| namedBlockDefinition
;

// ==================================================
// Multiline scripts
// ==================================================
sqlDefinition: (
	  SQL
	| EXPRESSION
	| EXPRESSION_CUSTOM_FILTER
)
	SQL_WS_NL* SQL_VALUE
;
htmlDefinition: HTML HTML_WS_NL* HTML_VALUE;

// ==================================================
// Generic value definition
// ==================================================
valueDefinition: IDENT COLON value;
value
	: STRING_VALUE
	| intValue
	| yesNoValue
	// keyword
	| keywordValue
	// arrays
	| intArrayValue
	| stringArrayValue
	| kvArrayValue
	| keywordArrayValue
	// untyped array
	| untypedArrayValue
;
intValue: (PLUS | MINUS)? INT_VALUE;
yesNoValue: (YES | NO);
// keyword
keywordValue: IDENT | TIMEZONE_SLASH;
// arrays
intArrayValue: LBRA (INT_VALUE (COMMA INT_VALUE)* COMMA?)? RBRA;
stringArrayValue: LBRA (STRING_VALUE (COMMA STRING_VALUE)* COMMA?)? RBRA;
kvArrayValue: LBRA (kvItem (COMMA kvItem)* COMMA?)? RBRA;
keywordArrayValue: LBRA (keywordArrayItem (COMMA keywordArrayItem)* COMMA?)? RBRA;
keywordArrayItem: MINUS? IDENT STAR?;

// key value
kvItem: IDENT COLON kvValue;
kvValue
	// currently supported types
	: STRING_VALUE
	| IDENT
	// pasable, but not supported types
	| intValue
	| yesNoValue
;

// broken array
untypedArrayValue: LBRA untypedArrayItem (COMMA untypedArrayItem)* COMMA? RBRA;
untypedArrayItem: STRING_VALUE | intValue | yesNoValue | keywordValue | kvItem;

// ==================================================
// Block definitions
// ==================================================
blockDefinition:
	IDENT COLON LCURL
		definition*
	RCURL
;

namedBlockDefinition:
	IDENT COLON PLUS? IDENT LCURL
		definition*
	RCURL
;
