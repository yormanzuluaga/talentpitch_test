import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// The code snippet is defining an extension called `AppLocalizationsX`
/// on the `BuildContext` class.
extension AppLocalizationsX on BuildContext {
  /// The line `AppLocalizations get l10n => AppLocalizations.of(this);`
  /// is defining a getter method called `l10n` that returns an instance
  /// of `AppLocalizations`.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
