import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_meeting/generated/l10n/app_localizations.dart';

/// [LoginPage] 클래스는 사용자가 비밀번호를 입력하는 화면을 표시하는 [StatefulWidget] 입니다.
///
/// 이 화면은 앱의 보안을 위한 첫 번째 관문 역할을 합니다.
/// 사용자는 4자리 숫자로 된 비밀번호를 입력해야 합니다.
class LoginPage extends StatefulWidget {
  /// [LoginPage]의 생성자입니다.
  ///
  /// [key]는 위젯 트리의 특정 위치에 있는 위젯을 식별하는 데 사용됩니다.
  const LoginPage({super.key});

  /// 위젯의 상태 객체를 생성합니다.
  ///
  /// Flutter 프레임워크가 위젯을 빌드할 때 이 메소드를 호출합니다.
  /// @return 이 위젯의 상태를 관리할 [_LoginPageState] 인스턴스를 반환합니다.
  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// [_LoginPageState] 클래스는 [LoginPage] 위젯의 상태를 관리합니다.
///
/// 이 클래스는 비밀번호 입력 필드의 상태, UI 구성 및 관련 로직을 처리합니다.
class _LoginPageState extends State<LoginPage> {
  /// 비밀번호 입력을 제어하는 컨트롤러입니다.
  ///
  /// 사용자가 입력하는 텍스트를 관리하고, 필드를 지우는 등의 작업을 수행합니다.
  final TextEditingController _passwordController = TextEditingController();

  /// 사용자가 입력한 비밀번호를 확인하고 결과를 처리합니다.
  ///
  /// 비밀번호가 정확하면 [HomePage]로 이동하고, 그렇지 않으면 오류 메시지를
  /// [SnackBar]로 표시합니다.
  void _checkPassword() {
    const correctPassword = '1234';
    final enteredPassword = _passwordController.text;

    if (enteredPassword == correctPassword) {
      // 홈 화면으로 이동하기 전에 현재 표시된 스낵바를 모두 제거합니다.
      ScaffoldMessenger.of(context).clearSnackBars();
      // GoRouter를 사용하여 홈 화면으로 이동합니다.
      context.go('/home');
    } else {
      // 비밀번호가 틀리면 스낵바를 표시합니다.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.loginErrorPasswordIncorrect),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      // 입력 필드를 초기화합니다.
      _passwordController.clear();
    }
  }

  /// 위젯이 위젯 트리에서 영구적으로 제거될 때 호출되어 리소스를 해제합니다.
  ///
  /// 여기서는 [_passwordController]를 정리하여 메모리 누수를 방지합니다.
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  /// 화면의 사용자 인터페이스(UI)를 빌드합니다.
  ///
  /// 이 메소드는 위젯이 화면에 그려질 때마다 호출됩니다.
  ///
  /// @param context 위젯 트리 내에서 위젯의 위치를 식별하는 데 사용되는 [BuildContext] 객체입니다.
  /// @return 화면에 표시될 [Widget]을 반환합니다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              Text(
                AppLocalizations.of(context)!.loginPageTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.passwordHint,
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
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
                // onSubmitted: (_) => _checkPassword(),
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
                  onPressed: _checkPassword,
                  child: Text(AppLocalizations.of(context)!.confirmButton),
                ),
              ),
              const Spacer(flex: 3),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 32.0),
                  child: Text('Made by ML'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
