# Expense Tracker App (Flutter)

A responsive personal finance and expense tracking mobile app built with Flutter. Record income and expenses, manage budgets and visualise your spending with charts. Data is stored locally on the device.

## Features
- Splash screen, login and register screens
- Dashboard with balance card
- Add and browse transactions
- Budgets and categories
- Analytics screen with charts (`fl_chart`)
- Profile screen
- Offline local storage with Hive

## Tech Stack
- Flutter (Dart SDK >=3.4)
- State management: `provider`
- Storage: `hive`, `hive_flutter`, `shared_preferences`
- Charts: `fl_chart`; fonts: `google_fonts`; formatting: `intl`

## Project Structure
```
lib/
├── main.dart, app.dart, routes.dart
├── models/      # budget, category, transaction
├── screens/     # splash, auth, dashboard, transactions, analytics, profile
├── services/    # database_service (Hive)
├── utils/       # colors, constants
└── widgets/     # balance card, buttons, text fields, transaction tile
```

## Getting Started
Requires the [Flutter SDK](https://docs.flutter.dev/get-started/install).
```bash
flutter pub get
flutter run
```
Targets Android and iOS.