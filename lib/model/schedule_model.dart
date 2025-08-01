/// [schedule_model] 클래스는 하나의 일정 데이터를 나타내는 데이터 모델입니다.
///
/// 이 클래스는 불변(immutable) 데이터 구조를 가지며, 각 일정의 속성을 정의합니다.
///
/// @property id 일정의 고유 식별자입니다.
/// @property date 일정이 예정된 날짜입니다.
/// @property location 일정이 진행될 장소입니다.
/// @property notes 일정에 대한 추가적인 메모나 설명입니다.
class schedule_model {
  final String id;
  final DateTime date;
  final String location;
  final String notes;

  /// [schedule_model]의 생성자입니다.
  ///
  /// 모든 매개변수는 필수적으로 요구됩니다.
  ///
  /// @param id 고유 식별자
  /// @param date 날짜
  /// @param location 장소
  /// @param notes 내용
  schedule_model({
    required this.id,
    required this.date,
    required this.location,
    required this.notes,
  });
}
