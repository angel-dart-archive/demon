import 'package:source_span/source_span.dart';
import '../token.dart';
import 'ast_node.dart';
import 'route_map.dart';

class RoutesDeclarationContext extends AstNode {
  final Token ROUTES;
  final RouteMapContext routeMap;

  RoutesDeclarationContext(this.ROUTES, this.routeMap);

  @override
  FileSpan get span => ROUTES.span.expand(routeMap.span);
}