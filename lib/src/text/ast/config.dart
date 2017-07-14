import 'package:source_span/source_span.dart';
import 'ast_node.dart';
import 'option_decl.dart';
import 'route.dart';

class ConfigurationContext extends AstNode {
  final OptionsDeclarationContext optionsDeclaration;
  final RoutesDeclarationContext routesDeclaration;

  ConfigurationContext(this.optionsDeclaration, this.routesDeclaration);

  @override
  FileSpan get span => routesDeclaration.span;
}
