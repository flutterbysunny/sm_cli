import 'dart:io';

void createMainFile(String projectName) {
  final file = File('$projectName/lib/main.dart');

  file.writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SM CLI App',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      routerConfig: appRouter,
    );
  }
}
''');

  print('📝 main.dart generated');
}