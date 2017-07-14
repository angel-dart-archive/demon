import 'package:source_span/source_span.dart';

abstract class AstNode {
  FileSpan get span;
  
  String toSource() => span.text;
}