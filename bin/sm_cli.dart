import 'dart:io';

import 'package:args/args.dart';
import 'package:sm_cli/commands/init_command.dart';
import 'package:sm_cli/commands/make_command.dart';
import 'package:sm_cli/services/prompt_service.dart';

void main(List<String> arguments) async {
  final parser = ArgParser();

  // INIT COMMAND
  final initCommand = ArgParser()
    ..addFlag('riverpod', abbr: 'r', negatable: false)
    ..addFlag('bloc', abbr: 'b', negatable: false)
    ..addFlag('getx', abbr: 'g', negatable: false)
    ..addFlag('provider', abbr: 'p', negatable: false);

  parser.addCommand('init', initCommand);

  // MAKE COMMAND
  final makeFeatureCommand = ArgParser();
  final makeApiCommand = ArgParser();

  final makeCommand = ArgParser()
    ..addCommand('feature', makeFeatureCommand)
    ..addCommand('api', makeApiCommand);

  parser.addCommand('make', makeCommand);

  // HELP
  parser.addFlag('help', abbr: 'h', negatable: false, help: 'Show help');
  parser.addFlag('version', abbr: 'v', negatable: false, help: 'Show version');

  ArgResults results;
  try {
    results = parser.parse(arguments);
  } catch (e) {
    print('❌ $e');
    _printHelp();
    return;
  }

  if (results['help'] == true || arguments.isEmpty) {
    _printHelp();
    return;
  }

  if (results['version'] == true) {
    print('sm_cli version 1.0.4');
    return;
  }

  // ---- INIT ----
  if (results.command?.name == 'init') {
    final command = results.command!;

    if (command.rest.isEmpty) {
      print('❌ Please provide project name');
      print('   Usage: sm init <project_name>');
      return;
    }

    final projectName = command.rest.first;

    bool riverpod = command['riverpod'] as bool;
    bool bloc = command['bloc'] as bool;
    bool getx = command['getx'] as bool;
    bool provider = command['provider'] as bool;

    String selected;
    if (riverpod) {
      selected = 'Riverpod';
    } else if (bloc) {
      selected = 'Bloc';
    } else if (getx) {
      selected = 'GetX';
    } else if (provider) {
      selected = 'Provider';
    } else {
      selected = selectStateManagement();
    }

    final useGoRouter = enableGoRouter();
    final useTheme = enableTheme();

    await initProject(
      projectName: projectName,
      riverpod: selected == 'Riverpod',
      bloc: selected == 'Bloc',
      getx: selected == 'GetX',
      useGoRouter: useGoRouter,
      useTheme: useTheme,
    );
  }

  // ---- MAKE ----
  else if (results.command?.name == 'make') {
    final subCommand = results.command!.command;

    if (subCommand == null) {
      print('❌ Please provide sub command');
      print('   Usage: cd <project_name> && sm make feature <feature_name>');
      print('          cd <project_name> && sm make api');
      return;
    }

    // FEATURE
    if (subCommand.name == 'feature') {
      if (subCommand.rest.isEmpty) {
        print('❌ Please provide feature name');
        print('   Usage: cd <project_name> && sm make feature <feature_name>');
        return;
      }

      // Sirf project folder ke andar se kaam karega
      final insideProject = Directory('lib').existsSync() &&
          Directory('lib/features').existsSync() &&
          File('pubspec.yaml').existsSync();

      if (!insideProject) {
        print('❌ Please run this command inside your Flutter project folder');
        print('   Usage: cd <project_name> && sm make feature <feature_name>');
        return;
      }

      await makeFeature(
        projectName: '.',
        featureName: subCommand.rest.first,
      );
    }

    // API
    else if (subCommand.name == 'api') {
      final insideProject = Directory('lib').existsSync() &&
          Directory('lib/core').existsSync() &&
          File('pubspec.yaml').existsSync();

      if (!insideProject) {
        print('❌ Please run this command inside your Flutter project folder');
        print('   Usage: cd <project_name> && sm make api');
        return;
      }

      await makeApi(projectName: '.');
    }
  }

  else {
    _printHelp();
  }
}

void _printHelp() {
  print('''
🚀 SM CLI - Flutter Clean Architecture Generator

Usage:
  sm init <project_name>         Create new Flutter project
  sm make feature <name>         Generate a new feature (run inside project)
  sm make api                    Generate API layer (run inside project)

Flags for init:
  -r, --riverpod    Use Riverpod (default: interactive)
  -b, --bloc        Use Bloc
  -g, --getx        Use GetX
  -p, --provider    Use Provider
  -h, --help        Show this help
  -v, --version     Show version

Examples:
  sm init my_app
  sm init my_app --riverpod
  cd my_app
  sm make feature auth
  sm make api
''');
}