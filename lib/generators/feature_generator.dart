import 'dart:io';
import '../services/config_service.dart';

void generateFeature({
  required String projectName,
  required String featureName,
}) {
  final stateManagement = ConfigService.readStateManagement(projectName);

  final folders = [
    // DATA
    'lib/features/$featureName/data/datasource',
    'lib/features/$featureName/data/models',
    'lib/features/$featureName/data/repository',

    // DOMAIN
    'lib/features/$featureName/domain/entities',
    'lib/features/$featureName/domain/repository',
    'lib/features/$featureName/domain/usecases',

    // PRESENTATION - common
    'lib/features/$featureName/presentation/screens',
    'lib/features/$featureName/presentation/widgets',
  ];

  // State management ke hisaab se extra folders
  if (stateManagement == 'Bloc') {
    folders.add('lib/features/$featureName/presentation/bloc');
  } else if (stateManagement == 'GetX') {
    folders.add('lib/features/$featureName/presentation/controllers');
    folders.add('lib/features/$featureName/presentation/bindings');
    folders.add('lib/features/$featureName/presentation/views');
  } else {
    // Riverpod & Provider
    folders.add('lib/features/$featureName/presentation/providers');
  }

  for (final folder in folders) {
    Directory('$projectName/$folder').createSync(recursive: true);
  }

  createFeatureFiles(
    projectName: projectName,
    featureName: featureName,
    stateManagement: stateManagement,
  );

  addRouteConstant(projectName: projectName, featureName: featureName);
  addRoute(projectName: projectName, featureName: featureName);

  print('✅ Feature "$featureName" generated ($stateManagement)');
}

void createFeatureFiles({
  required String projectName,
  required String featureName,
  required String stateManagement,
}) {
  // Screen — sabke liye common
  File(
    '$projectName/lib/features/$featureName/presentation/screens/${featureName}_screen.dart',
  ).writeAsStringSync('''
import 'package:flutter/material.dart';

class ${capitalize(featureName)}Screen extends StatelessWidget {
  const ${capitalize(featureName)}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${capitalize(featureName)}'),
      ),
      body: const Center(
        child: Text('${capitalize(featureName)} Screen'),
      ),
    );
  }
}
''');

  // State management ke hisaab se files
  if (stateManagement == 'Bloc') {
    _createBlocFiles(projectName, featureName);
  } else if (stateManagement == 'GetX') {
    _createGetXFiles(projectName, featureName);
  } else if (stateManagement == 'Provider') {
    _createProviderFiles(projectName, featureName);
  } else {
    _createRiverpodFiles(projectName, featureName);
  }

  // Domain + Data — sabke liye common
  File('$projectName/lib/features/$featureName/domain/entities/${featureName}_entity.dart')
      .writeAsStringSync('class ${capitalize(featureName)}Entity {}\n');

  File('$projectName/lib/features/$featureName/domain/repository/${featureName}_repository.dart')
      .writeAsStringSync('abstract class ${capitalize(featureName)}Repository {}\n');

  File('$projectName/lib/features/$featureName/domain/usecases/${featureName}_usecase.dart')
      .writeAsStringSync('class ${capitalize(featureName)}UseCase {}\n');

  File('$projectName/lib/features/$featureName/data/models/${featureName}_model.dart')
      .writeAsStringSync('class ${capitalize(featureName)}Model {}\n');

  File('$projectName/lib/features/$featureName/data/datasource/${featureName}_remote_datasource.dart')
      .writeAsStringSync('class ${capitalize(featureName)}RemoteDataSource {}\n');

  File('$projectName/lib/features/$featureName/data/repository/${featureName}_repository_impl.dart')
      .writeAsStringSync('''
import '../../domain/repository/${featureName}_repository.dart';

class ${capitalize(featureName)}RepositoryImpl implements ${capitalize(featureName)}Repository {}
''');

  print('📝 Feature files generated');
}

void _createBlocFiles(String projectName, String featureName) {
  final path = '$projectName/lib/features/$featureName/presentation/bloc';

  File('$path/${featureName}_event.dart').writeAsStringSync('''
part of '${featureName}_bloc.dart';

abstract class ${capitalize(featureName)}Event {}

class Load${capitalize(featureName)}Event extends ${capitalize(featureName)}Event {}
''');

  File('$path/${featureName}_state.dart').writeAsStringSync('''
part of '${featureName}_bloc.dart';

abstract class ${capitalize(featureName)}State {}

class ${capitalize(featureName)}Initial extends ${capitalize(featureName)}State {}
class ${capitalize(featureName)}Loading extends ${capitalize(featureName)}State {}
class ${capitalize(featureName)}Loaded extends ${capitalize(featureName)}State {}
class ${capitalize(featureName)}Error extends ${capitalize(featureName)}State {
  final String message;
  ${capitalize(featureName)}Error(this.message);
}
''');

  File('$path/${featureName}_bloc.dart').writeAsStringSync('''
import 'package:flutter_bloc/flutter_bloc.dart';

part '${featureName}_event.dart';
part '${featureName}_state.dart';

class ${capitalize(featureName)}Bloc extends Bloc<${capitalize(featureName)}Event, ${capitalize(featureName)}State> {
  ${capitalize(featureName)}Bloc() : super(${capitalize(featureName)}Initial()) {
    on<Load${capitalize(featureName)}Event>(_onLoad);
  }

  Future<void> _onLoad(
    Load${capitalize(featureName)}Event event,
    Emitter<${capitalize(featureName)}State> emit,
  ) async {
    emit(${capitalize(featureName)}Loading());
    // TODO: load data
    emit(${capitalize(featureName)}Loaded());
  }
}
''');
}

void _createRiverpodFiles(String projectName, String featureName) {
  File(
    '$projectName/lib/features/$featureName/presentation/providers/${featureName}_provider.dart',
  ).writeAsStringSync('''
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ${featureName}Provider = StateNotifierProvider<${capitalize(featureName)}Notifier, ${capitalize(featureName)}State>((ref) {
  return ${capitalize(featureName)}Notifier();
});

class ${capitalize(featureName)}State {
  final bool isLoading;
  final String? error;
  const ${capitalize(featureName)}State({this.isLoading = false, this.error});
}

class ${capitalize(featureName)}Notifier extends StateNotifier<${capitalize(featureName)}State> {
  ${capitalize(featureName)}Notifier() : super(const ${capitalize(featureName)}State());

  Future<void> load() async {
    state = const ${capitalize(featureName)}State(isLoading: true);
    // TODO: load data
    state = const ${capitalize(featureName)}State();
  }
}
''');
}

void _createGetXFiles(String projectName, String featureName) {
  File(
    '$projectName/lib/features/$featureName/presentation/controllers/${featureName}_controller.dart',
  ).writeAsStringSync('''
import 'package:get/get.dart';

class ${capitalize(featureName)}Controller extends GetxController {
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    // TODO: load data
    isLoading.value = false;
  }
}
''');

  File(
    '$projectName/lib/features/$featureName/presentation/views/${featureName}_view.dart',
  ).writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/${featureName}_controller.dart';

class ${capitalize(featureName)}View extends GetView<${capitalize(featureName)}Controller> {
  const ${capitalize(featureName)}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${capitalize(featureName)}'),
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : const Center(child: Text('${capitalize(featureName)} View')),
      ),
    );
  }
}
''');

  File(
    '$projectName/lib/features/$featureName/presentation/bindings/${featureName}_binding.dart',
  ).writeAsStringSync('''
import 'package:get/get.dart';
import '../controllers/${featureName}_controller.dart';

class ${capitalize(featureName)}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${capitalize(featureName)}Controller>(
      () => ${capitalize(featureName)}Controller(),
    );
  }
}
''');
}

void _createProviderFiles(String projectName, String featureName) {
  File(
    '$projectName/lib/features/$featureName/presentation/providers/${featureName}_provider.dart',
  ).writeAsStringSync('''
import 'package:flutter/material.dart';

class ${capitalize(featureName)}Provider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    // TODO: load data
    isLoading = false;
    notifyListeners();
  }
}
''');
}

void addRoute({required String projectName, required String featureName}) {
  final routerFile = File('$projectName/lib/core/routes/app_router.dart');
  final content = routerFile.readAsStringSync();

  final featureImport =
      "import '../../features/$featureName/presentation/screens/${featureName}_screen.dart';";

  final routeBlock = '''
    GoRoute(
      path: AppRoutes.$featureName,
      builder: (context, state) => const ${capitalize(featureName)}Screen(),
    ),
''';

  String updated = content;

  if (!content.contains(featureImport)) {
    updated = updated.replaceFirst(
      "import 'package:go_router/go_router.dart';",
      "import 'package:go_router/go_router.dart';\n$featureImport",
    );
  }

  if (!content.contains("AppRoutes.$featureName")) {
    updated = updated.replaceFirst('routes: [', 'routes: [\n$routeBlock');
  }

  routerFile.writeAsStringSync(updated);
  print('🛣️ Route added');
}

void addRouteConstant({required String projectName, required String featureName}) {
  final file = File('$projectName/lib/core/routes/app_routes.dart');
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

String capitalize(String text) {
  return text[0].toUpperCase() + text.substring(1);
}