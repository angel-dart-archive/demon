import 'package:source_span/source_span.dart';
import '../token.dart';
import 'ast_node.dart';
import 'route_pair.dart';

class RouteMapContext extends AstNode {
  final Token LCURLY, RCURLY;
  final List<RoutePairContext> routePairs = [];

  RouteMapContext(this.LCURLY, this.RCURLY);

  FileSpan get span {
    return routePairs
        .fold<FileSpan>(LCURLY.span, (out, p) => out.expand(p.span))
        .expand(RCURLY.span);
  }
}
