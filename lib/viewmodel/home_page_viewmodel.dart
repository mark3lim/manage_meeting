import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [HomePageViewModel]은 홈 화면의 상태와 비즈니스 로직을 관리하는 클래스입니다.
///
/// Riverpod의 [Notifier]를 상속받아 상태 변경을 UI에 알립니다.
class HomePageViewModel extends Notifier<DateTime> {
  /// 초기 상태를 현재 날짜로 설정합니다.
  @override
  DateTime build() {
    return DateTime.now();
  }

  /// 달력을 이전 달로 이동시킵니다.
  void previousMonth() {
    state = DateTime(state.year, state.month - 1, 1);
  }

  /// 달력을 다음 달로 이동시킵니다.
  void nextMonth() {
    state = DateTime(state.year, state.month + 1, 1);
  }
}

/// [homePageProvider]는 [HomePageViewModel]의 인스턴스를 제공하는 프로바이더입니다.
///
/// UI에서 이 프로바이더를 통해 ViewModel에 접근할 수 있습니다.
final homePageProvider = NotifierProvider<HomePageViewModel, DateTime>(
  HomePageViewModel.new,
);

/// [pageIndexProvider]는 홈 화면의 [PageView]의 현재 페이지 인덱스를 관리합니다.
final pageIndexProvider = StateProvider<int>((ref) => 0);
