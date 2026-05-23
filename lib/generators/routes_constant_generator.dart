import 'dart:io';

void createRoutesFile(String projectName) {
  final file = File(
    '$projectName/lib/core/routes/app_routes.dart',
  );

  file.writeAsStringSync('''
class AppRoutes {
  static const home = '/';
}
''');

  print('🛣️ Route constants generated');
}