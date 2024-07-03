import 'package:flutter/material.dart';

import 'app.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const App());
}
