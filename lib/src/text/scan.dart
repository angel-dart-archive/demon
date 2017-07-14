import 'package:string_scanner/string_scanner.dart';
import 'package:demon/src/text/token.dart';
import 'package:demon/src/text/syntax_error.dart';

final RegExp _whitespace = new RegExp(r'[ \n\r\t]');
final RegExp _number = new RegExp(r'[0-9]+(\.[0-9]+)?');
final RegExp _id = new RegExp(r'[A-Za-z_][A-Za-z0-9_]*');
final RegExp _variable = new RegExp(r'\$[A-Za-z_][A-Za-z0-9_]*');
final RegExp _string = new RegExp(r"'(([^'\n])|(\\'))*'");

/// Scans input text into a linear set of tokens.
class Scanner {
  final List<Token> _tokens = [];
  final List<SyntaxError> _syntaxErrors = [];
  SpanScanner _scanner;

  Scanner(String text, {sourceUrl}) {
    _scanner = new SpanScanner(text, sourceUrl: sourceUrl);
  }

  /// Any syntax errors that were encountered while scanning;
  List<SyntaxError> get syntaxErrors => _syntaxErrors;

  /// All tokens that were successfully scanned.
  List<Token> get tokens => _tokens;

  void scan() {
    LineScannerState _invalidState;
    _scanner.scan(_whitespace);

    void flush() {
      if (_invalidState != null) {
        var span = _scanner.spanFrom(_invalidState);
        _syntaxErrors
            .add(new SyntaxError('Unexpected text "${span.text}".', span));
        _invalidState = null;
      }
    }

    while (_scanner.isDone) {
      List<Token> potential = [];
      _patterns.forEach((pattern, type) {
        if (_scanner.matches(pattern))
          potential.add(new Token(type, _scanner.lastSpan));
      });

      if (potential.isEmpty) {
        _invalidState = _scanner.state;
        _scanner.readChar();
      } else {
        flush();
        potential
            .sort((a, b) => b.span.text.length.compareTo(a.span.text.length));
        var token = potential.first;
        _tokens.add(token);
        _scanner.scan(token.span.text);
        _scanner.scan(_whitespace);
      }
    }

    flush();
  }
}

final Map<Pattern, TokenType> _patterns = {
  ':': TokenType.COLON,
  ',': TokenType.COMMA,
  '{': TokenType.LCURLY,
  '}': TokenType.RCURLY,
  '(': TokenType.LPAREN,
  ')': TokenType.RPAREN,
  'listen': TokenType.LISTEN,
  'options': TokenType.OPTIONS,
  'routes': TokenType.ROUTES,
  '+': TokenType.PLUS,
  _number: TokenType.NUMBER,
  _string: TokenType.STRING,
  _id: TokenType.ID,
  _variable: TokenType.VARIABLE
};
