# AI Generation (Flutter)

This repository contains a Flutter starter following the workspace `.trae` Flutter standards:

- Feature-based clean architecture under `lib/src/features`
- `flutter_bloc` for state management
- `get_it` + `injectable` for dependency injection
- `go_router` for navigation
- `dio` + `retrofit` for networking (prepared)
- `flutter_gen` for typed assets (configured)

## Prerequisites

- Flutter 3.38.5

## Setup

If this is the first time initializing the repo, generate platform folders:

```bash
flutter create . --project-name ai_generation --org com.example --overwrite
```

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

## Run

```bash
flutter run
```
