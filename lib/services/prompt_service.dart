import 'package:interact/interact.dart';

/// Prompts user to select state management interactively.
///
/// Returns one of: `'Riverpod'`, `'Bloc'`, `'GetX'`, `'Provider'`

String selectStateManagement() {
  final options = [
    'Riverpod',
    'Bloc',
    'GetX',
    'Provider',
  ];

  final selected = Select(
    prompt: 'Select State Management',
    options: options,
  ).interact();

  return options[selected];
}
/// Prompts user to enable GoRouter.

bool enableGoRouter() {
  return Confirm(
    prompt: 'Enable GoRouter?',
    defaultValue: true,
  ).interact();
}
/// Prompts user to enable Theme setup.

bool enableTheme() {
  return Confirm(
    prompt: 'Enable Theme?',
    defaultValue: true,
  ).interact();
}