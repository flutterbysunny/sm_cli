import 'dart:io';

void createRouterFile(String projectName) {
  final file = File(
    '$projectName/lib/core/routes/app_router.dart',
  );

  file.writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('🚀 Home Screen'),
        ),
      ),
    ),
  ],
);
''');

  print('🛣️ Router generated');
}