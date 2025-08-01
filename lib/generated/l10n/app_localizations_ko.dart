// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '미팅 관리자';

  @override
  String get loginPageTitle => '비밀번호 입력';

  @override
  String get passwordLabel => '비밀번호';

  @override
  String get passwordHint => '4자리 비밀번호를 입력하세요';

  @override
  String get confirmButton => '확인';

  @override
  String get loginErrorPasswordIncorrect => '비밀번호가 틀렸습니다. 다시 시도해주세요.';

  @override
  String get homePageTitle => '오늘의 미팅';

  @override
  String get menuPageTitle => '메뉴';

  @override
  String get upcomingEventsTitle => '다가오는 일정';
}
