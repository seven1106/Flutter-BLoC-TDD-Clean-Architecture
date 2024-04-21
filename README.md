# Flutter TDD Clean Architecture Bloc News App

This application was developed using a well-defined and decoupled architecture, following TDD (test-driven programming) as a working methodology, Clean Architecture to make the distribution of responsibilities in layers, always following the SOLID principles and applying Design Patterns to solve some common problems. With the intention of practicing the teachings of the (Flutter, TDD, Clean Architecture, SOLID e Design Patterns).

## Architecture Overview

The project follows the Clean Architecture principles, separating the app into different layers:

- **Presentation Layer**: Contains the Flutter widgets, Blocs, and UI-related logic.
- **Domain Layer**: Contains business logic and use cases.
- **Data Layer**: Manages data sources such as APIs and local databases.

## State Management

The app uses the Bloc pattern for state management. Blocs are responsible for managing the application's state and business logic.

## Service Locator

The `get_it` package is used as a service locator for dependency injection. It helps manage the app's dependencies in a clean and organized way.

## API Requests

Retrofit is used for making API requests to the News API. It provides a type-safe way to interact with RESTful APIs.

## Dart Object Comparison

The `equatable` package is employed for efficient comparison of Dart objects. This is particularly useful when working with Blocs and state changes.

## Database

Supabase

## Libraries and Tools

  - cupertino_icons: ^1.0.6
  - fpdart: ^1.1.0
  - supabase_flutter: ^2.3.4
  - flutter_bloc: ^8.1.5
  - get_it: ^7.6.7
  - dotted_border: ^2.1.0
  - image_picker: ^1.0.7
  - uuid: ^4.4.0
  - intl: ^0.19.0
  - internet_connection_checker_plus: ^2.2.0
  - hive: ^4.0.0-dev.2
  - isar_flutter_libs: ^4.0.0-dev.13
  - path_provider: ^2.1.0

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/yunus6116/Flutter-Bloc-Clean-Architecture.git

2. Navigate to the project directory:
    ```bash
    cd your-repo
3. Add your News API key:
   <br>
   Open the lib/core/secrets/app_secrets.dart file and locate the newsAPIKey variable. Replace with your actual supaBase API key and URL.
   <br>
   <br>
   // lib/core/secrets/app_secrets.dart
   <br>
    class AppSecrets {
      static const String supabaseUrl = 'your_actual_url';
      static const String supabaseAnonKey = 'your_actual_api_key';
    }
   <br>
   <br>
   Note: Keep your API key secure and do not share it publicly. Consider using environment variables or other secure methods to manage sensitive information in a production environment.

5. Install dependencies:
   
   ```bash
   flutter pub get

6. Run the app:
   
   ```bash
   flutter run
