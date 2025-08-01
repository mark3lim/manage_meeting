import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_meeting/generated/l10n/app_localizations.dart';
import 'package:manage_meeting/screen/widgets/calendar_card.dart';
import 'package:manage_meeting/screen/widgets/glassmorphic_bottom_nav_bar.dart';
import 'package:manage_meeting/screen/widgets/upcoming_events_card.dart';
import 'package:manage_meeting/viewmodel/home_page_viewmodel.dart';

/// [HomePage] 클래스는 로그인 성공 후 표시되는 메인 화면을 구성하는 [ConsumerWidget] 입니다.
///
/// 이 화면은 월별 달력과 하단 네비게이션 바를 포함하고 있습니다.
/// 사용자는 달력을 통해 날짜를 확인하고, 네비게이션 바를 통해 다른 메뉴로 이동할 수 있습니다.
class HomePage extends ConsumerWidget {
  /// [HomePage]의 생성자입니다.
  ///
  /// [key]는 위젯 트리의 특정 위치에 있는 위젯을 식별하는 데 사용됩니다.
  const HomePage({super.key});

  /// 화면의 사용자 인터페이스(UI)를 빌드합니다.
  ///
  /// 이 메소드는 위젯이 화면에 그려질 때마다 호출됩니다.
  ///
  /// @param context 위젯 트리 내에서 위젯의 위치를 식별하는 데 사용되는 [BuildContext] 객체입니다.
  /// @param ref [Provider]를 읽기 위해 사용되는 객체입니다.
  /// @return 화면에 표시될 [Widget]을 반환합니다.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true, // 바디를 네비게이션 바 뒤까지 확장하여 유리 효과가 보이게 함
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        bottom: false, // 하단 SafeArea는 네비게이션 바에서 직접 처리
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0), // 하단 패딩 제거
          child: PageView(
            onPageChanged: (index) =>
                ref.read(pageIndexProvider.notifier).state = index,
            children: [
              ListView(
                children: [
                  Text(
                    AppLocalizations.of(context)!.homePageTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const CalendarCard(), // 분리된 달력 위젯 사용
                  const UpcomingEventsCard(), // "다가오는 일정" 카드 위젯 추가
                  const SizedBox(height: 100), // 하단 네비게이션 바와의 간격 확보
                ],
              ),
              const Center(child: Text('Page 2')),
              const Center(child: Text('Page 3')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const GlassmorphicBottomNavBar(), // 분리된 하단 네비게이션 바 위젯 사용
    );
  }
}
