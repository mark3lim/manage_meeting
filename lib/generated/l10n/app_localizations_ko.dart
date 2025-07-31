// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Task Manager';

  @override
  String get loginPasswordPrompt => '비밀번호 4자리를 입력하세요';

  @override
  String get loginPasswordLabel => '비밀번호';
}
