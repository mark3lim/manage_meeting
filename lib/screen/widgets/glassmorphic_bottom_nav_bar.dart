import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// [GlassmorphicBottomNavBar]는 iOS 스타일의 "리퀴드 글래스" UI를 적용한 하단 네비게이션 바입니다.
class GlassmorphicBottomNavBar extends StatelessWidget {
  /// [GlassmorphicBottomNavBar]의 생성자입니다.
  const GlassmorphicBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                      color: index == 0
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
