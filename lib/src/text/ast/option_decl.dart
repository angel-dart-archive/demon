import 'package:source_span/source_span.dart';
import '../token.dart';
import 'ast_node.dart';
import 'option.dart';

class OptionsDeclarationContext extends AstNode {
  final Token OPTIONS;
  final List<OptionContext> options = [];

  OptionsDeclarationContext(this.OPTIONS);

  @override
  FileSpan get span =>
      options.fold<FileSpan>(OPTIONS.span, (out, o) => out.expand(o.span));
}
