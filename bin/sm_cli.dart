import 'package:args/args.dart';
import 'package:sm_cli/commands/init_command.dart';
import 'package:sm_cli/commands/make_command.dart';
import 'package:sm_cli/generators/api_generator.dart';
import 'package:sm_cli/services/prompt_service.dart';

void main(List<String> arguments) async {
  final parser = ArgParser();

  // INIT COMMAND
  final initCommand = ArgParser()
    ..addFlag('riverpod', abbr: 'r')
    ..addFlag('bloc', abbr: 'b')
    ..addFlag('getx', abbr: 'g');

  parser.addCommand('init', initCommand);

  // MAKE COMMAND
  final makeFeatureCommand = ArgParser();
  final makeApiCommand = ArgParser(); // 👈 FIXED HERE

  final makeCommand = ArgParser()
    ..addCommand('feature', makeFeatureCommand)
    ..addCommand('api', makeApiCommand); // 👈 FIXED HERE

  parser.addCommand('make', makeCommand);

  final results = parser.parse(arguments);

  // INIT
  if (results.command?.name == 'init') {
    final command = results.command!;

    if (command.rest.isEmpty) {
      print('❌ Please provide project name');
      return;
    }

    final projectName = command.rest.first;

    final selected = selectStateManagement();

    enableGoRouter();
    enableTheme();

    await initProject(
      projectName: projectName,
      riverpod: selected == 'Riverpod',
      bloc: selected == 'Bloc',
      getx: selected == 'GetX',
    );
  }

  // MAKE
  else if (results.command?.name == 'make') {
    final subCommand = results.command!.command;

    if (subCommand == null) {
      print('❌ Please provide sub command (feature/api)');
      return;
    }

    // FEATURE
    if (subCommand.name == 'feature') {
      if (subCommand.rest.length < 2) {
        print('❌ Please provide project name and feature name');
        return;
      }

      final projectName = subCommand.rest[0];
      final featureName = subCommand.rest[1];

      await makeFeature(
        projectName: projectName,
        featureName: featureName,
      );
    }

    // API 👇 NEW FIXED PART
    else if (subCommand?.name == 'api') {
      await makeApi(
        projectName: subCommand.rest.isNotEmpty
            ? subCommand.rest.first
            : 'my_first_app',
      );
    }
  } else {
    print('👋 Welcome to SM CLI');
  }
}