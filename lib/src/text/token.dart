import 'package:source_span/source_span.dart';

class Token {
  final TokenType type;
  final FileSpan span;

  Token(this.type, this.span);
}

enum TokenType {
  COLON,
  COMMA,

  LCURLY,
  RCURLY,
  LPAREN,
  RPAREN,

  LISTEN,
  OPTIONS,
  ROUTES,

  PLUS,

  NUMBER,
  STRING,
  ID,
  VARIABLE
}
