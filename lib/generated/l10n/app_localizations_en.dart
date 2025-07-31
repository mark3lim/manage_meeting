// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Meeting Manager';

  @override
  String get splashScreenTitle => 'Meeting Management App';

  @override
  String get loginPageTitle => 'Enter Password';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter 4-digit number';

  @override
  String get confirmButton => 'Confirm';
}
