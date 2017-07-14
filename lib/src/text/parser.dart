import 'ast/ast.dart';
import 'syntax_error.dart';
import 'token.dart';

class Parser {
  Token _current;
  int _index = -1;
  final List<Token> tokens;

  Parser(this.tokens);

  Token get current => _current;

  bool next(TokenType type) {
    if (_index > tokens.length - 1) {
      var peek = tokens[_index + 1];
      if (peek.type == type) {
        _current = tokens[++_index];
        return true;
      } else return false;
    } else return false;
  }

  LiteralExpressionContext parseLiteral() => parseString() ?? parseNumber();
  
  StringExpressionContext parseString() {
    if (next(TokenType.STRING))
      return new StringExpressionContext(current);
    else return null;
  }
  
  NumberExpressionContext parseNumber() {
    if (next(TokenType.NUMBER))
      return new NumberExpressionContext(current);
    else return null;
  }
}