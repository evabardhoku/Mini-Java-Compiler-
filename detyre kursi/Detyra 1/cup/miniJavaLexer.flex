/* JFlex example: pjesa e SPECIFIKIMEVE te leksikut te gjuhes MiniJava */

import java_cup.runtime.*;



/**
 * This class is a simple example lexer.
 */
%%
/* Section for directives and definitions */
/* directives: */
%standalone
%public
%class miniJavaLexer
/* give this name to the lexer class! */

%extends Sym
%debug
%unicode /* the encoding of chars in the source files! */

%line 	/* enable line counting!   (used when debugging!) */
%column /* enable column counting! (used when debugging!) */
%cup

/* code we want in minijavaLexer */
%{
  StringBuffer string = new StringBuffer();
  Sym sym;

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

%eof{
  /* your code goes here */
%eof}


/*DEKLARIMET*/


LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}
TraditionalComment = "/*"[^*]~"*/"|"/*" "*"+"/"
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}
DocumentationComment = ".**"{CommentContent}"*"+"/"
CommentContent = ([^*] |\*[^/*])
Identifier = [:jletter:] [:jletterdigit:]*
DecIntegerLiteral = 0 | [1-9][0-9]*

%state STRING
%state NESTED_COMMENT

/* Seksioni i RREGULLAVE  */
%%

/* fjalet kyce */
<YYINITIAL> "class"              { return symbol(sym.CLASS); }
<YYINITIAL> "public"             { return symbol(sym.PUBLIC); }
<YYINITIAL> "static"             { return symbol(sym.STATIC); }
<YYINITIAL> "void"               { return symbol(sym.VOID); }
<YYINITIAL> "main"               { return symbol(sym.MAIN); }
<YYINITIAL> "String"             { return symbol(sym.STRING); }
<YYINITIAL> "if"                 { return symbol(sym.IF); }
<YYINITIAL> "else"               { return symbol(sym.ELSE); }
<YYINITIAL> "while"              { return symbol(sym.WHILE); }
<YYINITIAL> "length"             { return symbol(sym.LENGTH); }
<YYINITIAL> "true"               { return symbol(sym.TRUE); }
<YYINITIAL> "false"              { return symbol(sym.FALSE); }
<YYINITIAL> "this"               { return symbol(sym.THIS); }
<YYINITIAL> "new"                { return symbol(sym.NEW); }
<YYINITIAL> "boolean"            { return symbol(sym.BOOLEAN); }
<YYINITIAL> "int"                { return symbol(sym.INT); }
<YYINITIAL> "extends"            { return symbol(sym.EXTENDS); }
<YYINITIAL> "break"              { return symbol(sym.BREAK); }
<YYINITIAL> "abstract"           { return symbol(sym.ABSTRACT); }
<YYINITIAL> "return"             { return symbol(sym.RETURN); }
<YYINITIAL> "System.out.println" { return symbol(sym.SYSTEM); }

<YYINITIAL> {
  /* id */
  {Identifier}                   { return symbol(sym.IDENTIFIER); }

  /* literals */
  {DecIntegerLiteral}            { return symbol(sym.INTEGER_LITERAL); }
  \"                             { string.setLength(0); yybegin(STRING); }

  /* operators */
  "="                            { return symbol(sym.EQ); }
  "&&"                           { return symbol(sym.AND); }
  "+"                            { return symbol(sym.PLUS); }
  "-"                            { return symbol(sym.MINUS); }
  "*"                            { return symbol(sym.MUL); }
  "{"                            { return symbol(sym.LBRACE); }
  "}"                            { return symbol(sym.RBRACE); }
  "["                            { return symbol(sym.LBRACKET); }
  "]"                            { return symbol(sym.RBRACKET); }
  "("                            { return symbol(sym.LPAREN); }
  ")"                            { return symbol(sym.RPAREN); }
  ";"                            { return symbol(sym.SEMICOLON); }
  ","                            { return symbol(sym.COMMA); }
  "."                            { return symbol(sym.DOT); }
  "!"                            { return symbol(sym.NOT); }
  "<"                            { return symbol(sym.LT); }

  /* comments */
  {Comment}             { /* ignore */ }
  "/*"                           { /* your code goes here. Ne rastin tone, i injorojme komentet */ }

  /* hapesirat */
  {WhiteSpace}                   { /* ignore */ }
}

<STRING> {
  \"                             { yybegin(YYINITIAL);
                                   return symbol(sym.STRING_LITERAL,
                                   string.toString()); }
  [^\n\r\"\\]+                   { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\                             { string.append('\\'); }
}

/* error fallback */
<YYINITIAL>
[^]|\n                  { throw new Error("Illegal character <"+yytext()+">"); }

