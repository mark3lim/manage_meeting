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
  String get loginPageTitle => 'Enter Password';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your 4-digit password';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get loginErrorPasswordIncorrect =>
      'Incorrect password. Please try again.';

  @override
  String get homePageTitle => 'Today\'s Meetings';

  @override
  String get menuPageTitle => 'Menu';
}
