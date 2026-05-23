import 'dart:io';

void createThemeFile(String projectName) {
  final file = File(
    '$projectName/lib/core/theme/app_theme.dart',
  );

  file.writeAsStringSync('''
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.blue,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
  );
}
''');

  print('🎨 Theme generated');
}