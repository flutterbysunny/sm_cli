import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';

import 'app_routes.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.auth,
      builder: (context, state) => const AuthScreen(),
    ),

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
