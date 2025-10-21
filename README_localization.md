# Localization Guide

This app supports English and Arabic using Flutter's gen-l10n.

- ARB files live in `lib/l10n/`:
  - `app_en.arb` (English)
  - `app_ar.arb` (Arabic)
- The generated Dart classes live under `lib/l10n/` (already in repo).
- Access strings with `context.l10n` via the extension `lib/core/localization/l10n_ext.dart`.

## Adding new strings
1. Add keys to both `app_en.arb` and `app_ar.arb`. For example:
   - app_en.arb: `"greeting": "Hello {name}"` with placeholders in an `@greeting` entry
   - app_ar.arb: `"greeting": "مرحبًا {name}"`
2. Regenerate:
   ```powershell
   flutter gen-l10n
   ```
3. Use in code:
   ```dart
   Text(context.l10n.greeting(userName))
   ```

## Placeholders
- Use named placeholders in ARB with types. Example:
  ```json
  "priceWithCurrency": "Price : {price} {currency}",
  "@priceWithCurrency": {"placeholders": {"price": {"type": "num"}, "currency": {"type": "String"}}}
  ```

## Supported locales
- Configured in `main.dart` using `AppLocalizations.supportedLocales`.

## Persisting language
- We persist the selected `Locale` via `LocalizationCubit` using `SharedPreferences`.

