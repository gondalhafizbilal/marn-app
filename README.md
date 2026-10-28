# Marn

Marn is a Flutter marketplace app scaffolded with the same layered architecture pattern as `camion-app-v2`.

## What Is In This Scaffold

- App name: `Marn`
- Package name: `com.marn.app`
- Flavor support: `development` and `production`
- Environment files:
  - `.env.development`
  - `.env.production`
- Centralized bootstrap, DI, routing, API client, session handling, localization, and feature modules
- Native Android and iOS flavor setup with matching bundle IDs and app names
- Location permission declarations and Google Maps API key wiring

## Project Structure

- `lib/bootstrap.dart`
- `lib/marn_app.dart`
- `lib/core/`
- `lib/config/`
- `lib/routing/`
- `lib/features/`

## Run

Development:

```bash
flutter run --flavor development --target lib/main_development.dart --dart-define-from-file=.env.development
```

Production:

```bash
flutter run --flavor production --target lib/main_production.dart --dart-define-from-file=.env.production
```

The same flavor commands apply to Android and iOS.

## Notes

- The Android flavor setup is wired in `android/app/build.gradle.kts`.
- The iOS flavor setup is wired with shared schemes:
  - `development` -> `com.marn.app.development`, display name `Marn Dev`
  - `production` -> `com.marn.app`, display name `Marn`
- Add the platform Google Maps key to both env files:
  - `GOOGLE_MAPS_API_KEY=...`
- Android injects `GOOGLE_MAPS_API_KEY` into the manifest from `.env.<flavor>`.
- iOS reads `GOOGLE_MAPS_API_KEY` from the active bundled `.env.<flavor>` and passes it to Google Maps when the SDK is linked.

## Native Permissions

- Android declares foreground location permissions:
  - `ACCESS_COARSE_LOCATION`
  - `ACCESS_FINE_LOCATION`
- iOS declares:
  - `NSLocationWhenInUseUsageDescription`
