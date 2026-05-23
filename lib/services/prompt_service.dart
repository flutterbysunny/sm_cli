import 'package:interact/interact.dart';

String selectStateManagement() {
  final options = [
    'Riverpod',
    'Bloc',
    'GetX',
  ];

  final selected = Select(
    prompt: 'Select State Management',
    options: options,
  ).interact();

  return options[selected];
}

bool enableGoRouter() {
  return Confirm(
    prompt: 'Enable GoRouter?',
    defaultValue: true,
  ).interact();
}

bool enableTheme() {
  return Confirm(
    prompt: 'Enable Theme?',
    defaultValue: true,
  ).interact();
}