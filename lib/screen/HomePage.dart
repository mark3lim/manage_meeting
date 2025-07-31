import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// [HomePage] 클래스는 로그인 성공 후 표시되는 메인 화면을 구성하는 [StatefulWidget] 입니다.
///
/// 이 화면은 달력 UI와 함께 사용자에게 간단한 환영 메시지를 보여주는 역할을 합니다.
class HomePage extends StatefulWidget {
  /// [HomePage]의 생성자입니다.
  ///
  /// [key]는 위젯 트리의 특정 위치에 있는 위젯을 식별하는 데 사용됩니다.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 현재 달력에 표시된 월의 기준이 되는 날짜입니다.
  DateTime _currentDate = DateTime.now();

  /// 이전 달로 이동하는 함수입니다.
  void _previousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
    });
  }

  /// 다음 달로 이동하는 함수입니다.
  void _nextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
    });
  }

  /// 화면의 사용자 인터페이스(UI)를 빌드합니다.
  ///
  /// 이 메소드는 위젯이 화면에 그려질 때마다 호출됩니다.
  ///
  /// @param context 위젯 트리 내에서 위젯의 위치를 식별하는 데 사용되는 [BuildContext] 객체입니다.
  /// @return 화면에 표시될 [Widget]을 반환합니다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 1. 전체 배경화면은 흰색으로 설정
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '오늘의 미팅',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Card(
                margin: const EdgeInsets.only(top: 16.0),
                color: const Color(0xFFFFFFFF), // 2. 달력은 흰색에 가까운 회색(Hex 값)
                elevation: 0, // 그림자 제거
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: const BorderSide(color: Color(0xFF888888), width: 1.0), // 짙은 회색 테두리 추가
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCalendarHeader(context),
                    _buildCalendarDays(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 달력의 헤더(년/월 및 이전/다음 버튼)를 빌드합니다.
  ///
  /// @return 달력 헤더 위젯을 반환합니다.
  Widget _buildCalendarHeader(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: _previousMonth,
          ),
          Text(
            DateFormat.yMMMM(locale).format(_currentDate),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 18),
            onPressed: _nextMonth,
          ),
        ],
      ),
    );
  }

  /// 달력의 날짜 부분을 빌드합니다.
  ///
  /// 요일 헤더와 날짜 그리드를 포함합니다.
  ///
  /// @return 달력 날짜 위젯을 반환합니다.
  Widget _buildCalendarDays(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(_currentDate.year, _currentDate.month);
    final firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final firstWeekday = firstDayOfMonth.weekday % 7;
    final locale = Localizations.localeOf(context).languageCode;
    final weekDays = DateFormat.E(locale).dateSymbols.SHORTWEEKDAYS;
    final today = DateTime.now();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekDays.asMap().entries.map((entry) {
            final index = entry.key;
            final dayName = entry.value;
            final isSunday = index == 0;
            final isSaturday = index == 6;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                dayName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSunday ? Colors.red : (isSaturday ? Colors.blue : Colors.black),
                ),
              ),
            );
          }).toList(),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemCount: daysInMonth + firstWeekday,
          itemBuilder: (context, index) {
            if (index < firstWeekday) {
              return Container(); // 이전 달의 빈 공간
            }
            final day = index - firstWeekday + 1;
            final date = DateTime(_currentDate.year, _currentDate.month, day);
            final isSunday = date.weekday == DateTime.sunday;
            final isSaturday = date.weekday == DateTime.saturday;
            final isToday = DateUtils.isSameDay(date, today);

            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(4.0),
              decoration: isToday
                  ? const BoxDecoration( // 3. 오늘 날짜에는 빨간색 동그라미
                      color: Colors.red,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Text(
                '$day',
                style: TextStyle(
                  color: isToday
                      ? Colors.white
                      : (isSunday ? Colors.red : (isSaturday ? Colors.blue : Colors.black)),
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}