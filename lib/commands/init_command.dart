import 'dart:io';

import '../generators/folder_generator.dart';
import '../generators/main_generator.dart';
import '../services/flutter_service.dart';
import '../generators/router_generator.dart';
import '../generators/theme_generator.dart';
import '../generators/routes_constant_generator.dart';

Future<void> initProject({
  required String projectName,
  required bool riverpod,
  required bool bloc,
  required bool getx,
}) async {
  await createFlutterProject(projectName);

  createFolders(projectName);

  createMainFile(projectName);

  createRouterFile(projectName);

  createRoutesFile(projectName);

  createThemeFile(projectName);

  if (riverpod) {
    print('📦 Adding Riverpod dependencies...');

    final pubResult = await Process.run(
      'flutter',
      [
        'pub',
        'add',
        'flutter_riverpod',
        'go_router',
        'dio',
      ],
      workingDirectory: './$projectName',
      runInShell: true,
    );

    print(pubResult.stdout);
    print(pubResult.stderr);

    print('🔥 Riverpod architecture selected');
  }

  if (bloc) {
    print('📦 Adding Bloc dependencies...');

    await Process.run(
      'flutter',
      [
        'pub',
        'add',
        'flutter_bloc',
        'equatable',
      ],
      workingDirectory: './$projectName',
      runInShell: true,
    );

    print('🔥 Bloc architecture selected');
  }

  if (getx) {
    print('🔥 GetX architecture selected');
  }
}