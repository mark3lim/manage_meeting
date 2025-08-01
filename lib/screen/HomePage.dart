import 'dart:ui';

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
      extendBody: true, // 1. 바디를 네비게이션 바 뒤까지 확장하여 유리 효과가 보이게 함
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false, // 2. 하단 SafeArea는 네비게이션 바에서 직접 처리
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0), // 하단 패딩 제거
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '오늘의 미팅',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Card(
                margin: const EdgeInsets.only(top: 16.0),
                color: const Color(0xFFFFFFFF),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: const BorderSide(color: Color(0xFF888888), width: 1.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCalendarHeader(context),
                    _buildCalendarDays(context),
                  ],
                ),
              ),
              const Spacer(), // 3. 남은 공간을 채워 내용과 네비게이션 바가 겹치지 않게 함
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(), // 4. 하단 네비게이션 바 추가
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
    final daysInMonth =
        DateUtils.getDaysInMonth(_currentDate.year, _currentDate.month);
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
                  color: isSunday
                      ? Colors.red
                      : (isSaturday ? Colors.blue : Colors.black),
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
                  ? const BoxDecoration(
                      // 3. 오늘 날짜에는 빨간색 동그라미
                      color: Colors.red,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Text(
                '$day',
                style: TextStyle(
                  color: isToday
                      ? Colors.white
                      : (isSunday
                          ? Colors.red
                          : (isSaturday ? Colors.blue : Colors.black)),
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  /// iOS 26 스타일의 "리퀴드 글래스" UI를 적용한 하단 네비게이션 바를 빌드합니다.
  ///
  /// @return 하단 네비게이션 바 위젯을 반환합니다.
  Widget _buildBottomNavBar() {
    return ClipRRect(
      // 상단 모서리를 둥글게 처리하여 부드러운 느낌을 줍니다.
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      child: BackdropFilter(
        // 배경을 흐리게 하여 "프로스티드 글래스" 효과를 만듭니다.
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: 90.0, // 네비게이션 바의 높이
          padding: const EdgeInsets.fromLTRB(
              20.0, 10.0, 20.0, 25.0), // 내부 여백 (하단은 SafeArea 고려)
          decoration: BoxDecoration(
            // 반투명한 흰색으로 유리 느낌을 강조합니다.
            color: Colors.white.withOpacity(0.5),
            // 상단 테두리를 추가하여 경계를 명확히 합니다.
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.7), width: 1.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. 햄버거 메뉴 아이콘
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.black54, size: 28),
                onPressed: () {
                  // TODO: 햄버거 메뉴 기능 구현
                },
              ),
              // 2. 페이지 위치를 나타내는 점
              Row(
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: 9.0,
                    height: 9.0,
                    decoration: BoxDecoration(
                      // 현재 페이지(첫 번째)를 검은색으로, 나머지는 회색으로 표시합니다.
                      color: index == 0
                          ? Colors.black54
                          : Colors.grey.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              // 3. 설정 메뉴 아이콘
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
