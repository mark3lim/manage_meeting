import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_meeting/features/task/presentation/views/splash_screen.dart';
import 'package:manage_meeting/generated/l10n/app_localizations.dart';

/// 애플리케이션의 메인 진입점입니다.
///
/// @author limtaegyun
/// @version 1.0
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// MyApp 클래스는 애플리케이션의 루트 위젯입니다.
///
/// @author limtaegyun
/// @version 1.0
class MyApp extends StatelessWidget {
  /// MyApp의 생성자입니다.
  ///
  /// [key]는 위젯의 키입니다.
  const MyApp({super.key});

  /// 이 위젯은 애플리케이션의 루트입니다.
  ///
  /// [context]는 현재 위젯의 BuildContext 입니다.
  /// @return 위젯
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashScreen(),
    );
  }
}