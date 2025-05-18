# General Instructions for Copilot

Any commands will be run in PowerShell, so please use PowerShell syntax.

# Project Coding Standards

## General Guidelines
- Use Dart for all code.
- Follow Flutter best practices for UI and state management.
- Use `const` wherever possible to optimize widget rebuilds.
- Use `final` for variables that should not be reassigned.

## Naming Conventions
- Use PascalCase for class names and widget names.
- Use camelCase for variables, methods, and function names.
- Prefix private members with an underscore (_).

## Error Handling
- Use `try-catch` blocks for async operations.
- Log errors with sufficient context for debugging.

## Testing
- Write unit tests for all business logic.
- Write widget tests for UI components.
- Use the `test` package for unit and widget tests.

## Project Structure
- Organize code into `lib/` with subfolders for `models`, `services`, `pages`, `widgets`, and `utils`.
- Place assets in the `assets/` folder and reference them in `pubspec.yaml`.

## Dependencies
- Use `pubspec.yaml` to manage dependencies.
- Avoid adding unnecessary dependencies to keep the app lightweight.

## Comments
- Write clear and concise comments for complex logic.
- Use DartDoc comments for public APIs.
