import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_meeting/viewmodel/home_page_viewmodel.dart';

/// [GlassmorphicBottomNavBar]는 반투명한 "유리" 효과를 가진 하단 네비게이션 바 위젯입니다.
///
/// [ConsumerWidget]으로 구현되어 [pageIndexProvider]의 상태를 구독하고,
/// 현재 페이지에 따라 페이지 표시기(indicator)를 업데이트합니다.
class GlassmorphicBottomNavBar extends ConsumerWidget {
  /// [GlassmorphicBottomNavBar]의 생성자입니다.
  ///
  /// @param key 위젯의 고유 식별자입니다.
  const GlassmorphicBottomNavBar({super.key});

  /// 위젯의 UI를 빌드합니다.
  ///
  /// @param context 위젯 트리에서의 위치 정보를 담은 [BuildContext].
  /// @param ref 프로바이더를 읽고 상호작용하기 위한 [WidgetRef].
  /// @return 빌드된 [Widget].
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: 90.0,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 25.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.7), width: 1.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.black54, size: 28),
                onPressed: () => context.push('/menu'),
              ),
              Row(
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: 9.0,
                    height: 9.0,
                    decoration: BoxDecoration(
                      color: index == pageIndex
                          ? Colors.black54
                          : Colors.grey.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined,
                    color: Colors.black54, size: 28),
                onPressed: () {
                  // TODO: 설정 화면으로 이동하는 기능 구현
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
