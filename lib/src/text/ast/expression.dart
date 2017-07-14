import 'package:angel_framework/angel_framework.dart';
import 'ast_node.dart';

abstract class ExpressionContext extends AstNode {
  RequestHandler compile();
}
