import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manage_meeting/generated/l10n/app_localizations.dart';

/// LoginPage 클래스는 사용자가 비밀번호를 입력하는 화면을 표시하는 StatefulWidget 입니다.
///
/// 이 화면은 앱의 보안을 위한 첫 번째 관문 역할을 합니다.
/// 사용자는 4자리 숫자로 된 비밀번호를 입력해야 합니다.
class LoginPage extends StatefulWidget {
  /// LoginPage의 생성자입니다.
  ///
  /// [key]는 위젯 트리의 특정 위치에 있는 위젯을 식별하는 데 사용됩니다.
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// _LoginPageState 클래스는 LoginPage 위젯의 상태를 관리합니다.
///
/// 이 클래스는 비밀번호 입력 필드의 상태, UI 구성 및 관련 로직을 처리합니다.
class _LoginPageState extends State<LoginPage> {
  /// 비밀번호 입력을 제어하는 컨트롤러입니다.
  ///
  /// 사용자가 입력하는 텍스트를 관리하고, 필드를 지우는 등의 작업을 수행합니다.
  final TextEditingController _passwordController = TextEditingController();

  /// 위젯이 위젯 트리에서 영구적으로 제거될 때 호출됩니다.
  ///
  /// 여기서는 _passwordController를 정리하여 메모리 누수를 방지합니다.
  @override
  void dispose() {
    _passwordController.dispose();
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
    // 화면의 높이를 가져옵니다.
    final screenHeight = MediaQuery.of(context).size.height;
    // AppBar의 높이를 가져옵니다.
    final appBarHeight = AppBar().preferredSize.height;
    // 상태 표시줄의 높이를 가져옵니다.
    final statusBarHeight = MediaQuery.of(context).padding.top;

    // 비밀번호 입력 필드의 상단 위치를 계산합니다.
    // 화면 상단에서 40% 위치에서 AppBar와 상태 표시줄 높이를 뺍니다.
    final passwordFieldTop = screenHeight * 0.40 - appBarHeight - statusBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.loginPageTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: passwordFieldTop > 0 ? passwordFieldTop : 0),
            Text(
              AppLocalizations.of(context)!.passwordLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.passwordHint,
                border: const OutlineInputBorder(),
                counterText: '',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 4,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              autofillHints: null,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB4CBF0),
                  foregroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                onPressed: () {
                  // TODO: 비밀번호 확인 로직 구현
                },
                child: Text(AppLocalizations.of(context)!.confirmButton),
              ),
            ),
            const Spacer(),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 32.0),
                child: Text('Made by ML'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
