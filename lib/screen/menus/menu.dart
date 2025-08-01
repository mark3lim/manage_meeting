import 'package:flutter/material.dart';
import 'package:manage_meeting/generated/l10n/app_localizations.dart';

/// [MenuPage] 클래스는 앱의 주요 메뉴 항목을 표시하는 화면입니다.
///
/// 이 화면에서 사용자는 다양한 기능으로 접근할 수 있습니다.
class MenuPage extends StatelessWidget {
  /// [MenuPage]의 생성자입니다.
  const MenuPage({super.key});

  /// 화면의 사용자 인터페이스(UI)를 빌드합니다.
  ///
  /// @param context 위젯 트리 내에서 위젯의 위치를 식별하는 데 사용되는 [BuildContext] 객체입니다.
  /// @return 화면에 표시될 [Widget]을 반환합니다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.menuPageTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        // TODO: '메뉴 페이지' 문자열을 AppLocalizations를 사용하여 지역화하는 것을 권장합니다.
        // 예: child: Text(AppLocalizations.of(context).menuPageBody),
        child: Text('메뉴 페이지'), 
      ),
    );
  }
}
