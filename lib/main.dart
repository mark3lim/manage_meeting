import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_meeting/generated/l10n/app_localizations.dart';
import 'package:manage_meeting/LoginPage.dart';

/// Flutter 애플리케이션의 최상위 진입점입니다.
///
/// 이 함수는 앱을 실행하고 Riverpod 상태 관리를 위한 ProviderScope로 앱의 루트 위젯을 감쌉니다.
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// MyApp 클래스는 애플리케이션의 루트 위젯입니다.
///
/// 이 위젯은 앱의 기본 테마, 라우팅 및 현지화를 설정하는 MaterialApp을 구성합니다.
class MyApp extends StatelessWidget {
  /// MyApp의 생성자입니다.
  ///
  /// [key]는 위젯 트리의 특정 위치에 있는 위젯을 식별하는 데 사용됩니다.
  const MyApp({super.key});

  /// 이 위젯은 애플리케이션의 루트입니다.
  ///
  /// MaterialApp을 설정하고 앱의 전반적인 모양과 느낌을 정의합니다.
  ///
  /// @param context 위젯의 위치를 알려주는 BuildContext 객체입니다.
  /// @return 앱의 루트 위젯을 반환합니다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meeting Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      home: const SplashScreen(),
    );
  }
}

/// SplashScreen 클래스는 앱이 시작될 때 표시되는 초기 화면입니다.
///
/// 이 화면은 잠시 동안 앱의 브랜딩이나 로딩 상태를 보여준 후 메인 화면으로 전환됩니다.
class SplashScreen extends StatefulWidget {
  /// SplashScreen의 생성자입니다.
  ///
  /// [key]는 위젯 트리의 특정 위치에 있는 위젯을 식별하는 데 사용됩니다.
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// _SplashScreenState 클래스는 SplashScreen의 상태를 관리합니다.
///
/// 이 클래스는 화면 전환을 위한 타이머를 관리하고 화면의 UI를 구성합니다.
class _SplashScreenState extends State<SplashScreen> {
  /// 화면 전환을 제어하는 타이머 객체입니다.
  Timer? _timer;

  /// 위젯이 처음으로 생성될 때 호출됩니다.
  ///
  /// 여기서는 2초 후에 LoginPage로 이동하는 타이머를 설정합니다.
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    });
  }

  /// 위젯이 위젯 트리에서 영구적으로 제거될 때 호출됩니다.
  ///
  /// 여기서는 _timer를 취소하여 메모리 누수를 방지합니다.
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// 화면의 사용자 인터페이스(UI)를 빌드합니다.
  ///
  /// 이 메소드는 위젯이 화면에 그려질 때마다 호출됩니다.
  ///
  /// @param context 위젯의 위치를 알려주는 BuildContext 객체입니다.
  /// @return 화면에 표시될 위젯을 반환합니다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(AppLocalizations.of(context)!.splashScreenTitle),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 32.0),
            child: Text('Made by ML'),
          ),
        ],
      ),
    );
  }
}
