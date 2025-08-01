import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [HomePageViewModel]은 홈 화면의 주 상태(선택된 날짜)와
/// 관련된 비즈니스 로직을 관리하는 뷰모델 클래스입니다.
///
/// Riverpod의 [Notifier]를 상속받아 상태를 관리하며, UI에 상태 변경을 알립니다.
class HomePageViewModel extends Notifier<DateTime> {
  /// [build] 메소드는 뷰모델의 초기 상태를 설정합니다.
  ///
  /// 여기서는 현재 날짜를 초기 선택된 날짜로 지정합니다.
  /// @return [DateTime] 초기 상태로 사용될 현재 날짜.
  @override
  DateTime build() {
    return DateTime.now();
  }

  /// 달력을 이전 달로 이동시킵니다.
  ///
  /// 현재 상태(state)의 날짜에서 한 달을 빼서 상태를 업데이트합니다.
  void previousMonth() {
    state = DateTime(state.year, state.month - 1, 1);
  }

  /// 달력을 다음 달로 이동시킵니다.
  ///
  /// 현재 상태(state)의 날짜에서 한 달을 더해서 상태를 업데이트합니다.
  void nextMonth() {
    state = DateTime(state.year, state.month + 1, 1);
  }
}

/// [homePageProvider]는 [HomePageViewModel]의 인스턴스를 UI에 제공하는 프로바이더입니다.
///
/// UI 위젯은 이 프로바이더를 통해 [HomePageViewModel]에 접근하고 상태를 구독할 수 있습니다.
final homePageProvider = NotifierProvider<HomePageViewModel, DateTime>(
  HomePageViewModel.new,
);

/// [pageIndexProvider]는 홈 화면의 [PageView] 위젯의 현재 페이지 인덱스를 관리하는 프로바이더입니다.
///
/// [StateProvider]를 사용하여 간단한 정수 값을 상태로 관리합니다.
final pageIndexProvider = StateProvider<int>((ref) => 0);
