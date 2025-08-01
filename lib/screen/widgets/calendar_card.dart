import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:manage_meeting/viewmodel/home_page_viewmodel.dart';
import 'package:manage_meeting/viewmodel/schedule_viewmodel.dart';

/// [CalendarCard]는 홈 화면에 월별 달력을 표시하는 위젯입니다.
///
/// [ConsumerWidget]으로 구현되어 [homePageProvider]를 통해 현재 선택된 달의 상태를
/// 관리하고, 사용자가 이전/다음 달로 이동할 수 있는 상호작용을 제공합니다.
class CalendarCard extends ConsumerWidget {
  /// [CalendarCard]의 생성자입니다.
  ///
  /// @param key 위젯의 고유 식별자입니다.
  const CalendarCard({super.key});

  /// 위젯의 UI를 빌드합니다.
  ///
  /// @param context 위젯 트리에서의 위치 정보를 담은 [BuildContext].
  /// @param ref 프로바이더를 읽고 상호작용하기 위한 [WidgetRef].
  /// @return 빌드된 [Widget].
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDate = ref.watch(homePageProvider);
    final viewModel = ref.read(homePageProvider.notifier);

    return Card(
      margin: const EdgeInsets.only(top: 16.0),
      color: Theme.of(context).colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 1.0
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCalendarHeader(context, currentDate, viewModel),
          _buildCalendarDays(context, currentDate, ref),
        ],
      ),
    );
  }

  /// 달력의 헤더(년/월 및 이전/다음 달 이동 버튼)를 생성합니다.
  ///
  /// @param context [BuildContext] 객체.
  /// @param currentDate 현재 달력에 표시된 날짜.
  /// @param viewModel [HomePageViewModel] 인스턴스.
  /// @return 헤더 부분을 나타내는 [Widget].
  Widget _buildCalendarHeader(
      BuildContext context, DateTime currentDate, HomePageViewModel viewModel) {
    final locale = Localizations.localeOf(context).languageCode;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: viewModel.previousMonth,
          ),
          Text(
            DateFormat.yMMMM(locale).format(currentDate),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 18),
            onPressed: viewModel.nextMonth,
          ),
        ],
      ),
    );
  }

  /// 달력의 날짜(요일 및 일자) 부분을 격자 형태로 생성합니다.
  ///
  /// @param context [BuildContext] 객체.
  /// @param currentDate 현재 달력에 표시된 날짜.
  /// @param ref [WidgetRef] 객체.
  /// @return 날짜 그리드를 나타내는 [Widget].
  Widget _buildCalendarDays(BuildContext context, DateTime currentDate, WidgetRef ref) {
    final schedulesAsyncValue = ref.watch(scheduleProvider);
    final scheduledDates = schedulesAsyncValue.when(
      data: (schedules) => schedules.map((s) => s.date).toList(),
      loading: () => [],
      error: (e, s) => [],
    );

    final daysInMonth =
        DateUtils.getDaysInMonth(currentDate.year, currentDate.month);
    final firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
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
                      : (isSaturday
                          ? Colors.blue
                          : Theme.of(context).colorScheme.onSurface),
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
              return Container();
            }
            final day = index - firstWeekday + 1;
            final date = DateTime(currentDate.year, currentDate.month, day);
            final isSunday = date.weekday == DateTime.sunday;
            final isSaturday = date.weekday == DateTime.saturday;
            final isToday = DateUtils.isSameDay(date, today);
            final hasEvent = scheduledDates.any((d) => DateUtils.isSameDay(d, date));

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(4.0),
                  decoration: isToday
                      ? BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        )
                      : null,
                  child: Text(
                    '$day',
                    style: TextStyle(
                      color: isToday
                          ? Theme.of(context).colorScheme.onPrimary
                          : (isSunday
                              ? Colors.red
                              : (isSaturday
                                  ? Colors.blue
                                  : Theme.of(context).colorScheme.onSurface)),
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                if (hasEvent)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    width: 6.0,
                    height: 6.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF9800),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
