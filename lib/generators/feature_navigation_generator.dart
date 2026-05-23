import 'dart:io';

void createFeatureNavigationFile(String projectName) {
  final file = File(
    '$projectName/lib/core/routes/feature_routes.dart',
  );

  file.writeAsStringSync('''
final featureRoutes = <Map<String, String>>[];
''');

  print('🧭 Feature navigation generated');
}