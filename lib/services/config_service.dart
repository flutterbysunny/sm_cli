import 'dart:io';
import 'dart:convert';

/// Manages SM CLI project configuration.
///
/// Saves and reads the `.sm_cli_config` file in the project root.
/// This allows `sm make feature` to auto-detect state management
/// without asking every time.

class ConfigService {
  static const _configFile = '.sm_cli_config';
  /// Saves project config to `.sm_cli_config` file.
  ///
  /// Called automatically during `sm init`.
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
  /// Reads state management from `.sm_cli_config`.
  ///
  /// Returns `'Riverpod'` if config file not found.

  static String readStateManagement(String projectName) {
    final file = File('$projectName/$_configFile');
    if (!file.existsSync()) return 'Riverpod';
    final config = jsonDecode(file.readAsStringSync());
    return config['state_management'] ?? 'Riverpod';
  }
}