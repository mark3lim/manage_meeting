import 'package:flutter/material.dart';

/// [schedule_model] 클래스는 하나의 일정 데이터를 나타내는 데이터 모델입니다.
///
/// 이 클래스는 불변(immutable) 데이터 구조를 가지며, 각 일정의 속성을 정의합니다.
class ScheduleModel {
  final String id; // 일정 고유 아이디
  final DateTime date; // 일정 날짜
  final TimeOfDay time; // 일정 시작 시간
  final String location; // 일정 장소
  final String notes; // 일정 내용
  final String? organizer; // 일정 주체자 또는 개인
  final String? phoneNum; // 전화번호
  final String? email; // 이메일
  final String? url; //인터넷 주소


  /// [schedule_model]의 생성자입니다.
  ///
  /// 모든 매개변수는 필수적으로 요구됩니다.
  ScheduleModel({
    required this.id,
    required this.date,
    required this.time,
    required this.location,
    required this.notes,
    this.organizer,
    this.phoneNum,
    this.email,
    this.url,
  });
}
