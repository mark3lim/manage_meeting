// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '회의 관리 앱';

  @override
  String get splashScreenTitle => '회의 관리 앱';

  @override
  String get loginPageTitle => '비밀번호 입력';

  @override
  String get passwordLabel => '비밀번호';

  @override
  String get passwordHint => '4자리 숫자를 입력하세요';

  @override
  String get confirmButton => '확인';

  @override
  String get loginErrorPasswordIncorrect => '비밀번호가 틀렸습니다.';
}
