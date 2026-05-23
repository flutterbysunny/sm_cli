# Changelog

All notable changes to SM CLI will be documented here.

---

## [1.0.1] - 2026-05-23

### Added
- Flutter project initializer with clean architecture
- Multiple state management support — Riverpod, Bloc, GetX, Provider
- Feature generator with auto state management detection
- Bloc structure — bloc, event, state files auto generated
- GetX structure — controller, view, binding auto generated
- Riverpod & Provider — StateNotifier provider auto generated
- API layer generator — Dio client, interceptors, response wrapper
- GoRouter integration with auto route & constant generation
- Light & dark theme setup with Material 3
- Project config (`.sm_cli_config`) auto saved on init
- `--help` and `--version` flags
- Direct flags — `--riverpod`, `--bloc`, `--getx`, `--provider`


### Fixed
- Removed unused calculate() function from lib/sm_cli.dart

## [1.0.2] - 2026-05-23

### Fixed
- `sm make feature` now works from inside project folder as well