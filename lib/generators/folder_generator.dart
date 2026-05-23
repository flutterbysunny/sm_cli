import 'dart:io';

void createFolders(String projectName) {
  final folders = [
    'lib/core/constants',
    'lib/core/network',
    'lib/core/routes',
    'lib/core/theme',
    'lib/core/utils',
    'lib/features',
    'lib/shared',
  ];

  for (final folder in folders) {
    Directory('$projectName/$folder').createSync(recursive: true);
  }

  print('📁 Clean Architecture folders created');
}