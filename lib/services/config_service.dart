import 'dart:io';
import 'dart:convert';

class ConfigService {
  static const _configFile = '.sm_cli_config';

  static void saveConfig({
    required String projectName,
    required String stateManagement,
  }) {
    final file = File('$projectName/$_configFile');
    final config = {
      'state_management': stateManagement,
    };
    file.writeAsStringSync(jsonEncode(config));
  }

  static String readStateManagement(String projectName) {
    final file = File('$projectName/$_configFile');
    if (!file.existsSync()) return 'Riverpod';
    final config = jsonDecode(file.readAsStringSync());
    return config['state_management'] ?? 'Riverpod';
  }
}