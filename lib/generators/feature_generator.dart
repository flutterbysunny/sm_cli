import 'dart:io';

void generateFeature({
  required String projectName,
  required String featureName,
}) {
  final folders = [
    // DATA
    'lib/features/$featureName/data/datasource',
    'lib/features/$featureName/data/models',
    'lib/features/$featureName/data/repository',

    // DOMAIN
    'lib/features/$featureName/domain/entities',
    'lib/features/$featureName/domain/repository',
    'lib/features/$featureName/domain/usecases',

    // PRESENTATION
    'lib/features/$featureName/presentation/providers',
    'lib/features/$featureName/presentation/screens',
    'lib/features/$featureName/presentation/widgets',
  ];

  for (final folder in folders) {
    Directory('$projectName/$folder').createSync(recursive: true);
  }

  createFeatureFiles(
    projectName: projectName,
    featureName: featureName,
  );

  addRouteConstant(
    projectName: projectName,
    featureName: featureName,
  );

  addRoute(
    projectName: projectName,
    featureName: featureName,
  );

  print('✅ Feature "$featureName" generated');
}

void addRoute({
  required String projectName,
  required String featureName,
}) {
  final routerFile =
  File('$projectName/lib/core/routes/app_router.dart');

  final content = routerFile.readAsStringSync();

  final featureImport =
      "import '../../features/$featureName/presentation/screens/${featureName}_screen.dart';";

  final routeBlock = '''
    GoRoute(
      path: AppRoutes.$featureName,
      builder: (context, state) => const ${capitalize(featureName)}Screen(),
    ),
''';

  String updatedContent = content;

  // ✅ SAFE IMPORT ADD
  if (!content.contains(featureImport)) {
    updatedContent = updatedContent.replaceFirst(
      "import 'package:go_router/go_router.dart';",
      "import 'package:go_router/go_router.dart';\n$featureImport",
    );
  }

  // ✅ SAFE ROUTE ADD (NO DUPLICATE)
  if (!content.contains("AppRoutes.$featureName")) {
    updatedContent = updatedContent.replaceFirst(
      'routes: [',
      'routes: [\n$routeBlock',
    );
  }

  routerFile.writeAsStringSync(updatedContent);

  print('🛣️ Route added safely');
}

void addRouteConstant({
  required String projectName,
  required String featureName,
}) {
  final file =
  File('$projectName/lib/core/routes/app_routes.dart');

  final content = file.readAsStringSync();

  if (content.contains("static const $featureName")) {
    print('⚠️ Route constant already exists');
    return;
  }

  final updated = content.replaceFirst(
    '}',
    "  static const $featureName = '/$featureName';\n}",
  );

  file.writeAsStringSync(updated);

  print('🧭 Route constant added');
}

void createFeatureFiles({
  required String projectName,
  required String featureName,
}) {
  File(
    '$projectName/lib/features/$featureName/presentation/screens/${featureName}_screen.dart',
  ).writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_routes.dart';

class ${capitalize(featureName)}Screen extends StatelessWidget {
  const ${capitalize(featureName)}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${capitalize(featureName)} Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push(AppRoutes.home);
          },
          child: const Text('Go Home'),
        ),
      ),
    );
  }
}
''');

  File(
    '$projectName/lib/features/$featureName/presentation/providers/${featureName}_provider.dart',
  ).writeAsStringSync('''
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ${featureName}Provider = Provider<String>((ref) {
  return '${capitalize(featureName)} Provider';
});
''');

  File(
    '$projectName/lib/features/$featureName/data/repository/${featureName}_repository.dart',
  ).writeAsStringSync('''
class ${capitalize(featureName)}Repository {}
''');

  File(
    '$projectName/lib/features/$featureName/data/models/${featureName}_model.dart',
  ).writeAsStringSync('''
class ${capitalize(featureName)}Model {}
''');

  File(
    '$projectName/lib/features/$featureName/data/datasource/${featureName}_remote_datasource.dart',
  ).writeAsStringSync('''
class ${capitalize(featureName)}RemoteDataSource {}
''');

  File(
    '$projectName/lib/features/$featureName/domain/entities/${featureName}_entity.dart',
  ).writeAsStringSync('''
class ${capitalize(featureName)}Entity {}
''');

  File(
    '$projectName/lib/features/$featureName/domain/repository/${featureName}_repository.dart',
  ).writeAsStringSync('''
abstract class ${capitalize(featureName)}Repository {}
''');

  File(
    '$projectName/lib/features/$featureName/data/repository/${featureName}_repository_impl.dart',
  ).writeAsStringSync('''
import '../../domain/repository/${featureName}_repository.dart';

class ${capitalize(featureName)}RepositoryImpl
    implements ${capitalize(featureName)}Repository {}
''');

  File(
    '$projectName/lib/features/$featureName/domain/usecases/${featureName}_usecase.dart',
  ).writeAsStringSync('''
class ${capitalize(featureName)}UseCase {}
''');

  print('📝 Feature files generated');
}

String capitalize(String text) {
  return text[0].toUpperCase() + text.substring(1);
}