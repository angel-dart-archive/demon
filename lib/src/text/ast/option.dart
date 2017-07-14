import 'package:source_span/source_span.dart';
import '../token.dart';
import 'ast_node.dart';
import 'literal.dart';

class OptionContext extends AstNode {
  final Token NAME;
  final List<LiteralExpressionContext> arguments = [];

  OptionContext(this.NAME);

  @override
  FileSpan get span =>
      arguments.fold<FileSpan>(NAME.span, (out, a) => out.expand(a.span));
}
