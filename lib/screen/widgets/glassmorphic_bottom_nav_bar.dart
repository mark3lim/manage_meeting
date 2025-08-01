import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_meeting/viewmodel/home_page_viewmodel.dart';

/// [GlassmorphicBottomNavBar]는 반투명한 "유리" 효과를 가진 하단 네비게이션 바 위젯입니다.
///
/// [ConsumerStatefulWidget]으로 구현되어 [pageIndexProvider]의 상태를 구독하고,
/// 현재 페이지에 따라 페이지 표시기(indicator)를 업데이트하며, 팝업 메뉴의 상태를 관리합니다.
class GlassmorphicBottomNavBar extends ConsumerStatefulWidget {
  /// [GlassmorphicBottomNavBar]의 생성자입니다.
  ///
  /// @param key 위젯의 고유 식별자입니다.
  const GlassmorphicBottomNavBar({super.key});

  @override
  ConsumerState<GlassmorphicBottomNavBar> createState() =>
      _GlassmorphicBottomNavBarState();
}

class _GlassmorphicBottomNavBarState
    extends ConsumerState<GlassmorphicBottomNavBar>
    with SingleTickerProviderStateMixin {
  final GlobalKey _settingsIconKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  /// 설정 아이콘 위에 "Liquid Glass" 스타일의 팝업 메뉴를 표시합니다.
  ///
  /// 이 메소드는 오버레이를 사용하여 화면의 다른 위젯 위에 메뉴를 띄웁니다.
  void _showLiquidGlassMenu() {
    final context = _settingsIconKey.currentContext;
    if (context == null) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 메뉴 바깥을 탭하면 닫히도록 하는 GestureDetector
          Positioned.fill(
            child: GestureDetector(
              onTap: _hideLiquidGlassMenu,
              behavior: HitTestBehavior.translucent,
            ),
          ),
          // 팝업 메뉴 위치 지정
          Positioned(
            right: 20.0,
            bottom: size.height + 30,
            child: _buildLiquidGlassMenu(),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  /// 표시된 팝업 메뉴를 숨깁니다.
  void _hideLiquidGlassMenu() {
    if (_overlayEntry != null) {
      _animationController.reverse();
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  /// "Liquid Glass" 스타일의 메뉴 위젯을 빌드합니다.
  ///
  /// @return [Widget] 팝업 메뉴 위젯.
  Widget _buildLiquidGlassMenu() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(80),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.grey.withAlpha(120), width: 1.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuListItem(
                context,
                icon: Icons.logout,
                text: '로그아웃',
                onTap: () {
                  _hideLiquidGlassMenu();
                  context.go('/login');
                },
              ),
              const Divider(height: 1, color: Colors.white54, indent: 10, endIndent: 10),
              _buildMenuListItem(
                context,
                icon: Icons.settings,
                text: '설정',
                onTap: () {
                  _hideLiquidGlassMenu();
                  // TODO: 설정 화면으로 이동
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 팝업 메뉴의 각 항목을 빌드합니다.
  ///
  /// @param context [BuildContext]
  /// @param icon 항목의 아이콘
  /// @param text 항목의 텍스트
  /// @param onTap 탭했을 때 실행될 콜백
  /// @return [Widget] 메뉴 항목 위젯
  Widget _buildMenuListItem(BuildContext context, {required IconData icon, required String text, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.black54, size: 22),
              const SizedBox(width: 10),
              Text(text, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideLiquidGlassMenu();
    _animationController.dispose();
    super.dispose();
  }

  /// 위젯의 UI를 빌드합니다.
  ///
  /// @param context 위젯 트리에서의 위치 정보를 담은 [BuildContext].
  /// @return 빌드된 [Widget].
  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(pageIndexProvider);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: 90.0,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 25.0),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(128),
            border: Border(
              top: BorderSide(color: Colors.white.withAlpha(179), width: 1.5),
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
                          : Colors.grey.withAlpha(153),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              IconButton(
                key: _settingsIconKey,
                icon: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0)
                          .animate(_animationController),
                      child: _animationController.value < 0.5
                          ? const Icon(Icons.settings_outlined,
                              color: Colors.black54, size: 28)
                          : const Icon(Icons.settings,
                              color: Colors.black54, size: 28),
                    );
                  },
                ),
                onPressed: () {
                  if (_overlayEntry == null) {
                    _animationController.forward();
                    _showLiquidGlassMenu();
                  } else {
                    _hideLiquidGlassMenu();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
