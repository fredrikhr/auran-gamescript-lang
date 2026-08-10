grammar GS;

// Converted to ANTLR4 from TS12 TrainzUtil GameScript Documentation: Section 2.2 Keywords
KEYWORD_BREAK:
	'break'; // break from a for, while or switch statement
KEYWORD_CASE: 'case'; // case statement, same as c sytax
KEYWORD_CONTINUE: 'continue'; // continue a for or while statment
KEYWORD_DEFAULT: 'default'; // default switch statment, same as c
KEYWORD_ELSE: 'else'; // if - else
KEYWORD_FOR: 'for'; // for statement, same as c
KEYWORD_GOTO: 'goto'; // goto statment, same as c
KEYWORD_IF: 'if'; // if statement, same as c
KEYWORD_NULL: 'null'; // null, A null reference
KEYWORD_RETURN: 'return'; // return from a function
KEYWORD_SWITCH: 'switch'; // switch statemnt, same as c
KEYWORD_WHILE: 'while'; // while statment, same as c
KEYWORD_AND: 'and'; // and, same as && in c
KEYWORD_OR: 'or'; // or, same as || in c
KEYWORD_TRUE: 'true'; // true, boolean constant
KEYWORD_FALSE: 'false'; // false, boolean constant
KEYWORD_VOID:
	'void'; // void, used for blank function return types
KEYWORD_BOOL:
	'bool'; // bool, boolean variable type which may take the values true or false
KEYWORD_INT:
	'int'; // integer, signed natural number variable type (32 bit)
KEYWORD_FLOAT: 'float'; // floating point number, (32 bit)
KEYWORD_STRING: 'string'; // string type
KEYWORD_OBJECT: 'object'; // object type
KEYWORD_CLASS: 'class'; // class declaration keyword
KEYWORD_STATIC: 'static'; // static, class type specifier
KEYWORD_INCLUDE:
	'include'; // include keyword to include other .gs files
KEYWORD_PUBLIC:
	'public'; // public, type specifier to publically declare a variable or function
KEYWORD_NATIVE: 'native';
// native, function type specifier, to denote that this function is implemented in the game source
KEYWORD_FINAL: 'final';
// class or function specifier to indicate that the class cannot be extended, or the function cannot be overridden
KEYWORD_THREAD:
	'thread'; // function specifier to indicate the function is to start a new execution thread
KEYWORD_GAME: 'game';
// class specifier to indicate a game class, automatic if a function has a thread specifier
KEYWORD_SIZE: 'size'; // size operator for arrays and strings
KEYWORD_ISCLASS: 'isclass';
// isclass operator to test is a class is of another classes type, also used to extend or inherit from other classes.
KEYWORD_COPY: 'copy'; // copy operator for strings and arrays
KEYWORD_NEW:
	'new'; // new operator to create arrays, strings and objects
KEYWORD_ME: 'me'; // me, keyword simialar to c++'s this
KEYWORD_CAST:
	'cast'; // cast<> to cast from one type to another, also can use () in non object cases.
KEYWORD_WAIT:
	'wait'; // control flow statement for blocking on messages
KEYWORD_ON: 'on'; // blocking command
KEYWORD_DEFINE: 'define'; // const define declarator.
KEYWORD_OBSOLETE: 'obsolete';
KEYWORD_MANDATORY: 'mandatory';
KEYWORD_SECURED: 'secured';
KEYWORD_LEGACY_COMPATABILITY: 'legacy_compatibility';

// Converted to ANTLR4 from TS12 TrainzUtil GameScript Documentation: Section 2.3 Identifiers
fragment DIGIT: [0-9];
fragment LETTER: [a-zA-Z_];

IDENTIFIER: LETTER (LETTER | DIGIT)*;

// Converted to ANTLR4 from TS12 TrainzUtil GameScript Documentation: 2.4 Constants
fragment HEX: [a-fA-F] | DIGIT;
fragment PREFIX_L: 'L';
fragment ESCAPE_SEQUENCE: '\\' [rntlab\\"'0];

CONSTANT_INT: DIGIT+;
CONSTANT_FLOAT: (DIGIT* '.' DIGIT+ | DIGIT+ '.' DIGIT*) 'f'?;
CONSTANT_CHAR: PREFIX_L? '\'' (ESCAPE_SEQUENCE | ~[\\'])+ '\'';
CONSTANT_STRING: PREFIX_L? '"' (ESCAPE_SEQUENCE | ~[\\"])* '"';
CONSTANT_HEX: '0' [xX] HEX+;

// Converted to ANTLR4 from TS12 TrainzUtil GameScript Documentation: 2.6 Operators
SYMBOL_OP_DIM: '[]';
SYMBOL_INC: '++';
SYMBOL_DEC: '--';
SYMBOL_LEFT_SHIFT: '<<';
SYMBOL_RIGHT_SHIFT: '>>';
SYMBOL_LTE: '<=';
SYMBOL_GTE: '>=';
SYMBOL_EQ: '==';
SYMBOL_NEQ: '!=';

// Converted to ANTLR4 from TS12 TrainzUtil GameScript Documentation: Section 2.10 Grammar
program: include_declaration* class_declaration* EOF;
include_declaration: KEYWORD_INCLUDE include_file;
include_file: CONSTANT_STRING;
class_declaration:
	declaration_specifier* KEYWORD_CLASS identifier class_derivision_specifier? class_definition ';'
		;
class_derivision_specifier:
	KEYWORD_ISCLASS identifier (',' identifier)*;
class_definition: '{' declaration* '}';
declaration:
	function_declaration
	| function_prototype_declaration
	| variable_declaration_list
	| declaration_specifier* function_declaration
	| declaration_specifier* function_prototype_declaration
	| declaration_specifier* variable_declaration_list;
declaration_specifier:
	KEYWORD_PUBLIC
	| KEYWORD_NATIVE
	| KEYWORD_OBSOLETE ('(' (CONSTANT_INT | CONSTANT_HEX) ')')?
	| KEYWORD_DEFINE
	| KEYWORD_FINAL
	| KEYWORD_SECURED
	| KEYWORD_MANDATORY
	| KEYWORD_THREAD
	| KEYWORD_STATIC
	| KEYWORD_GAME
	| KEYWORD_LEGACY_COMPATABILITY;
function_prototype_declaration:
	type_specifier identifier function_parameter_declaration ';';
function_declaration:
	type_specifier identifier function_parameter_declaration compound_statement;
function_parameter_declaration:
	'(' ')'
	| '(' KEYWORD_VOID ')'
	| '(' parameter (',' parameter)* ')';
variable_declaration_list:
	type_specifier declarator (',' declarator)* ';';
declarator: identifier | identifier '=' constant_expression;
type_specifier:
	primitive_type
	| primitive_type SYMBOL_OP_DIM
	| identifier
	| identifier SYMBOL_OP_DIM;
primitive_type:
	KEYWORD_VOID
	| KEYWORD_BOOL
	| KEYWORD_INT
	| KEYWORD_FLOAT
	| KEYWORD_STRING
	| KEYWORD_OBJECT;
parameter: type_specifier identifier;
compound_statement: '{' '}' | '{' statement* '}';
statement:
	variable_declaration_list
	| labeled_statement
	| compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement;
labeled_statement:
	identifier ':' statement
	| KEYWORD_CASE constant_expression ':' statement
	| KEYWORD_DEFAULT ':' statement
	| KEYWORD_ON constant ',' constant ':' statement
	| KEYWORD_ON constant ',' constant ',' unary_expression ':' statement;
expression_statement: ';' | expression ';';
selection_statement:
	KEYWORD_IF '(' expression ')' statement
	| KEYWORD_IF '(' expression ')' statement KEYWORD_ELSE statement
	| KEYWORD_SWITCH '(' expression ')' compound_statement
	| KEYWORD_WAIT '(' ')' compound_statement;
iteration_statement:
	KEYWORD_WHILE '(' expression ')' statement
	| KEYWORD_FOR '(' expression_statement expression_statement ')' statement
	| KEYWORD_FOR '(' expression_statement expression_statement expression ')' statement;
jump_statement:
	KEYWORD_GOTO identifier ';'
	| KEYWORD_CONTINUE ';'
	| KEYWORD_BREAK ';'
	| KEYWORD_RETURN ';'
	| KEYWORD_RETURN expression ';';
constant_expression: logical_or_expression;
expression:
	assignment_expression
	| expression ',' assignment_expression;
assignment_expression:
	logical_or_expression
	| unary_expression '=' assignment_expression;
logical_or_expression:
	logical_and_expression
	| logical_or_expression KEYWORD_OR logical_and_expression;
logical_and_expression:
	inclusive_or_expression
	| logical_and_expression KEYWORD_AND inclusive_or_expression;
inclusive_or_expression:
	exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression;
exclusive_or_expression:
	and_expression
	| exclusive_or_expression '^' and_expression;
and_expression:
	equality_expression
	| and_expression '&' equality_expression;
equality_expression:
	relational_expression
	| equality_expression SYMBOL_EQ relational_expression
	| equality_expression SYMBOL_NEQ relational_expression;
relational_expression:
	shift_expression
	| relational_expression '<' shift_expression
	| relational_expression '>' shift_expression
	| relational_expression SYMBOL_LTE shift_expression
	| relational_expression SYMBOL_GTE shift_expression;
shift_expression:
	additive_expression
	| shift_expression SYMBOL_LEFT_SHIFT additive_expression
	| shift_expression SYMBOL_RIGHT_SHIFT additive_expression;
additive_expression:
	multiplicative_expression
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression;
multiplicative_expression:
	cast_expression
	| multiplicative_expression '*' cast_expression
	| multiplicative_expression '/' cast_expression
	| multiplicative_expression '%' cast_expression;
cast_expression:
	unary_expression
	| '(' primitive_type ')' cast_expression
	| '(' primitive_type SYMBOL_OP_DIM ')' cast_expression
	| KEYWORD_CAST '<' type_specifier '>' cast_expression;
unary_expression:
	postfix_expression
	| SYMBOL_INC unary_expression
	| SYMBOL_DEC unary_expression
	| unary_operator cast_expression;
unary_operator: '+' | '-' | '~' | '!';
postfix_expression:
	primary_expression
	| postfix_expression '[' ',' assignment_expression ']'
	| postfix_expression '[' assignment_expression ',' ']'
	| postfix_expression '[' assignment_expression ',' assignment_expression ']'
	| postfix_expression '[' assignment_expression ']'
	| postfix_expression '(' ')'
	| postfix_expression '(' assignment_expression (
		',' assignment_expression
	)* ')'
	| postfix_expression '.' identifier
	| postfix_expression SYMBOL_INC
	| postfix_expression SYMBOL_DEC
	| postfix_expression '.' KEYWORD_SIZE '(' ')'
	| postfix_expression '.' KEYWORD_ISCLASS '(' identifier ')'
	| postfix_expression '.' KEYWORD_COPY '(' assignment_expression ')';
primary_expression:
	identifier
	| KEYWORD_ME
	| KEYWORD_NULL
	| constant
	| new_expression
	| '(' expression ')';
new_expression:
	KEYWORD_NEW primitive_type '(' ')'
	| KEYWORD_NEW primitive_type '(' assignment_expression (
		',' assignment_expression
	)* ')'
	| KEYWORD_NEW primitive_type '[' expression ']'
	| KEYWORD_NEW identifier '(' ')'
	| KEYWORD_NEW identifier '(' assignment_expression (
		',' assignment_expression
	)* ')'
	| KEYWORD_NEW identifier '[' expression ']';
identifier: IDENTIFIER;
constant:
	CONSTANT_HEX
	| CONSTANT_INT
	| CONSTANT_CHAR
	| CONSTANT_FLOAT
	| CONSTANT_STRING
	| KEYWORD_TRUE
	| KEYWORD_FALSE;

// Skipped terminal tokens
NEWLINE: ('\r' '\n'? | '\n') -> skip;
WHITESPACE: [ \t]+ -> skip;

// Converted to ANTLR4 from TS12 TrainzUtil GameScript Documentation: Section 2.1 Comments
BLOCKCOMMENT: '/*' .*? '*/' -> channel(HIDDEN);
LINECOMMENT: '//' ~[\r\n]* -> channel(HIDDEN);
