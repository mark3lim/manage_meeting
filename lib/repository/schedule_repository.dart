import 'package:flutter/material.dart';
import 'package:manage_meeting/model/schedule_model.dart';

/// [schedule_repository] 클래스는 일정 데이터의 출처를 관리하고 제공하는 역할을 합니다.
///
/// 데이터 계층(Data Layer)의 일부로, 원격 서버, 로컬 데이터베이스 등
/// 다양한 데이터 소스로부터 일정 정보를 가져오는 로직을 캡슐화합니다.
/// 현재는 네트워크 지연을 시뮬레이션하는 임시 데이터를 사용하고 있습니다.
class schedule_repository {
  /// 다가오는 일정 목록을 비동기적으로 가져옵니다.
  ///
  /// 이 함수는 1초의 지연을 통해 실제 네트워크 요청을 시뮬레이션한 후,
  /// 하드코딩된 [ScheduleModel] 객체 리스트를 반환합니다.
  ///
  /// @return [Future<List<ScheduleModel>>] 일정 모델 객체들의 리스트를 담은 Future.
  Future<List<ScheduleModel>> fetchSchedules() async {
    // 네트워크 요청이나 데이터베이스 조회를 시뮬레이션하기 위해 약간의 지연을 줍니다.
    await Future.delayed(const Duration(seconds: 1));

    // 임시 데이터. 나중에는 실제 데이터로 교체됩니다.
    // 비어 있는 리스트를 반환하여 "일정 없음" 상태를 테스트하려면 아래 리스트를 비우세요.
    return [
      ScheduleModel(
        id: '1',
        date: DateTime.now().add(const Duration(days: 1)),
        time: const TimeOfDay(hour: 10, minute: 0),
        location: '독립문 앞 스타벅스',
        notes: '클라이언트 미팅',
        organizer: '홍길도',
        phoneNum: '010-1234-5678',
        email: 'hong@example.com',
        url: '',
      ),
      ScheduleModel(
        id: '2',
        date: DateTime.now().add(const Duration(days: 3)),
        time: TimeOfDay(hour: 16, minute: 30),
        location: '온라인 (Google Meet)',
        notes: '주간 팀 회의',
        organizer: '철수컴퍼니(주)',
        phoneNum: '02-1234-5678',
        email: 'lee@example.com',
        url: 'https://meet.google.com/abc-defg-hij',
      ),
    ];
  }
}
