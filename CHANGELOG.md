# Changelog

All notable changes to SM CLI will be documented here.

## [1.0.6] - 2026-05-27

### Fixed
- `sm make feature <project> <feature>` now works correctly from outside the project folder
- Feature folder no longer created inside `features/` with project name — correct path is `features/auth/` not `features/my_app/`

### Changed
- Commands now work from outside the project folder — no need to `cd` into project
- `sm make feature my_app auth` — project name required
- `sm make api my_app` — project name required
- `sm list my_app` — project name required

---


## [1.0.5] - 2026-05-24

### Added
- `sm list` — project mein saare features list karta hai with state management info
- Feature name validation — sirf `snake_case` allow hoga
- Existing feature overwrite protection — warning deta hai

### Fixed
- `sm list` command properly registered

---

## [1.0.4] - 2026-05-23

### Fixed
- `sm make feature` and `sm make api` now only work inside the project folder — clear error message shown when run from outside
- Feature name now generates correctly

### Improved
- `model` now auto-generates `fromJson` and `toJson` methods
- `usecase` now auto-generates `call()` method
- `remote_datasource` now auto-generates basic structure with Dio
- `repository_impl` now includes commented hints for implementation

---

## [1.0.3] - 2026-05-23

### Fixed
- Project name is now optional — after `cd my_app`, just run `sm make feature auth`
- `sm make api` works without project name as well
- GetX now correctly generates `screens` folder

---

## [1.0.2] - 2026-05-23

### Fixed
- `sm make feature` now works from inside the project folder

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
- Removed unused `calculate()` function from `lib/sm_cli.dart`