import 'package:go_router/go_router.dart';
import 'package:manage_meeting/LoginPage.dart';
import 'package:manage_meeting/screen/HomePage.dart';
import 'package:manage_meeting/screen/menus/menu.dart';

/// [router]는 앱의 네비게이션을 관리하는 [GoRouter] 인스턴스입니다.
final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/menu',
      builder: (context, state) => const MenuPage(),
    ),
  ],
);
