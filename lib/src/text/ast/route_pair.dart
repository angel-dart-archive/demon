import 'package:source_span/source_span.dart';
import '../token.dart';
import 'ast_node.dart';
import 'expression.dart';

class RoutePairContext extends AstNode {
  final Token STRING, COLON;
  final ExpressionContext expression;

  RoutePairContext(this.STRING, this.COLON, this.expression);

  @override
  FileSpan get span => STRING.span.expand(COLON.span).expand(expression.span);
}
