import 'package:test/test.dart';
import 'package:sm_cli/services/config_service.dart';

void main() {
  group('ConfigService', () {
    test('returns Riverpod as default when config not found', () {
      final result = ConfigService.readStateManagement('non_existing_project');
      expect(result, 'Riverpod');
    });
  });
}