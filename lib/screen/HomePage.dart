import 'package:flutter/material.dart';

/// [HomePage] 클래스는 로그인 성공 후 표시되는 메인 화면을 구성하는 [StatelessWidget] 입니다.
///
/// 이 화면은 사용자에게 간단한 환영 메시지를 보여주는 역할을 합니다.
class HomePage extends StatelessWidget {
  /// [HomePage]의 생성자입니다.
  ///
  /// [key]는 위젯 트리의 특정 위치에 있는 위젯을 식별하는 데 사용됩니다.
  const HomePage({super.key});

  /// 화면의 사용자 인터페이스(UI)를 빌드합니다.
  ///
  /// 이 메소드는 위젯이 화면에 그려질 때마다 호출됩니다.
  ///
  /// @param context 위젯 트리 내에서 위젯의 위치를 식별하는 데 사용되는 [BuildContext] 객체입니다.
  /// @return 화면에 표시될 [Widget]을 반환합니다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 숨기기
      ),
      body: const Center(
        child: Text(
          '환영합니다!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
