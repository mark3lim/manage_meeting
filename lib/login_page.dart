import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// LoginPage 클래스는 비밀번호 입력 화면을 표시하는 StatefulWidget 입니다.
///
/// @author marklim
/// @version 1.0
class LoginPage extends StatefulWidget {
  /// LoginPage의 생성자입니다.
  ///
  /// [key]는 위젯의 키입니다.
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// _LoginPageState 클래스는 LoginPage 위젯의 상태를 관리합니다.
///
/// 이 클래스는 비밀번호 입력 필드의 상태와 UI를 빌드합니다.
///
/// @author marklim
/// @version 1.0
class _LoginPageState extends State<LoginPage> {
  /// 비밀번호 입력을 위한 TextEditingController 입니다.
  final TextEditingController _passwordController = TextEditingController();

  /// 위젯이 소멸될 때 컨트롤러를 정리합니다.
  ///
  /// @return void
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  /// 화면의 UI를 빌드합니다.
  ///
  /// [context]는 현재 위젯의 BuildContext 입니다.
  /// @return 위젯
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 입력'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                hintText: '4자리 숫자를 입력하세요',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 4,
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
