import 'package:flutter/material.dart' show SizedBox;

extension Spacing on num {
  SizedBox get spaceVertical => SizedBox(height: toDouble(),);
  SizedBox get spaceHorizontal => SizedBox(width: toDouble(),);
}