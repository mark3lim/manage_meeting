import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_meeting/generated/l10n/app_localizations.dart';
import 'package:manage_meeting/router.dart';

/// 앱의 메인 진입점입니다.
void main() {
  runApp(
    // Riverpod를 사용하기 위해 ProviderScope로 앱을 감쌉니다.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// [MyApp] 클래스는 애플리케이션의 루트 위젯입니다.
///
/// 이 위젯은 [MaterialApp.router]를 사용하여 GoRouter와 통합되고,
/// 앱의 테마, 로컬라이제이션 등을 설정합니다.
class MyApp extends StatelessWidget {
  /// [MyApp]의 생성자입니다.
  const MyApp({super.key});

  /// 이 위젯은 애플리케이션의 루트입니다.
  ///
  /// @param context 위젯 트리 내에서 위젯의 위치를 식별하는 데 사용되는 [BuildContext] 객체입니다.
  /// @return 화면에 표시될 [Widget]을 반환합니다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // 라우터 설정을 GoRouter 인스턴스로 지정합니다.
      routerConfig: router,
      // 디버그 배너를 숨깁니다.
      debugShowCheckedModeBanner: false,
      // 앱의 제목을 설정합니다.
      title: 'Meeting Manager',
      // 앱의 테마를 설정합니다.
      theme: ThemeData(
        // Material Design 3를 활성화합니다.
        useMaterial3: true,
        // 앱의 기본 색상 팔레트를 정의합니다.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB4CBF0),
          // 주요 색상들을 직접 지정합니다.
          primary: Colors.red, // 오늘 날짜 표시 등에 사용
          surface: Colors.white, // 카드 배경색
          outline: const Color(0xFF888888), // 카드 테두리색
          onSurface: Colors.black, // 기본 텍스트 색상
          onPrimary: Colors.white, // Primary 색상 위의 텍스트 색상
        ),
        // 앱의 기본 텍스트 스타일을 정의합니다.
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16),
        ),
        // 앱 전체에 사용될 기본 폰트 패밀리를 지정합니다.
        // (요구사항에 따라 시스템 폰트 사용)
        fontFamily: null,
      ),
      // 로컬라이제이션 설정을 합니다.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // 지원하는 언어를 설정합니다.
      supportedLocales: AppLocalizations.supportedLocales,
      // 타이틀을 현지화합니다.
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
    );
  }
}
