import 'package:angel_framework/angel_framework.dart';
import 'package:source_span/source_span.dart';
import '../token.dart';
import 'expression.dart';

abstract class LiteralExpressionContext extends ExpressionContext {
  get value;
}

class StringExpressionContext extends LiteralExpressionContext {
  String _cache;
  final Token STRING;

  StringExpressionContext(this.STRING);

  @override
  FileSpan get span => STRING.span;

  @override
  get value => stringValue;

  String get stringValue =>
      _cache ??= STRING.span.text.substring(1, STRING.span.text.length - 2);

  @override
  RequestHandler compile() {
    return (RequestContext req, ResponseContext res) async {
      res.json(stringValue);
    };
  }
}

class NumberExpressionContext extends LiteralExpressionContext {
  num _cache;
  final Token NUMBER;

  NumberExpressionContext(this.NUMBER);

  @override
  FileSpan get span => NUMBER.span;

  @override
  get value => numberValue;

  num get numberValue => _cache ??= num.parse(span.text);

  @override
  RequestHandler compile() {
    return (RequestContext req, ResponseContext res) async {
      res.json(numberValue);
    };
  }
}
