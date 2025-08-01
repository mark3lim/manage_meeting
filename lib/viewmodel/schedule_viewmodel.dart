import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_meeting/model/schedule_model.dart';
import 'package:manage_meeting/repository/schedule_repository.dart';

/// [schedule_viewmodel]은 다가오는 일정 목록의 상태를 관리하는 비동기 뷰모델입니다.
///
/// Riverpod의 [AsyncNotifier]를 사용하여 비동기 작업(데이터 로딩)의 상태,
/// 즉 로딩, 데이터, 오류 상태를 자동으로 처리하고 UI에 반영합니다.
class schedule_viewmodel extends AsyncNotifier<List<schedule_model>> {
  /// [build] 메소드는 뷰모델이 처음 초기화될 때 호출됩니다.
  ///
  /// [schedule_repository]를 통해 비동기적으로 일정 데이터를 가져와
  /// 뷰모델의 초기 상태를 설정합니다.
  ///
  /// @return [Future<List<schedule_model>>] 비동기적으로 가져온 일정 목록.
  @override
  Future<List<schedule_model>> build() async {
    // 의존성 주입을 통해 repository 인스턴스를 생성하고 데이터를 가져옵니다.
    return await schedule_repository().fetchSchedules();
  }
}

/// [scheduleProvider]는 [schedule_viewmodel]의 인스턴스를 UI에 제공하는 프로바이더입니다.
///
/// [AsyncNotifierProvider]를 사용하여 비동기 상태를 관리하는 뷰모델을 생성하고,
/// UI 위젯이 이 프로바이더를 통해 뷰모델의 상태(로딩, 데이터, 오류)를 구독할 수 있게 합니다.
final scheduleProvider =
    AsyncNotifierProvider<schedule_viewmodel, List<schedule_model>>(
  schedule_viewmodel.new,
);
