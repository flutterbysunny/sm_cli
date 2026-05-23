import 'dart:io';

Future<void> createFlutterProject(String projectName) async {
  print('🚀 Creating Flutter project: $projectName');

  final result = await Process.run(
    'flutter',
    [
      'create',
      '--platforms=android,ios',
      projectName,
    ],
    runInShell: true,
  );

  print(result.stdout);
  print(result.stderr);

  print('✅ Flutter project created');
}