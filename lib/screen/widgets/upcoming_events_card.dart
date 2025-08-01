import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:manage_meeting/generated/l10n/app_localizations.dart';
import 'package:manage_meeting/viewmodel/schedule_viewmodel.dart';

/// [UpcomingEventsCard]는 다가오는 일정 목록을 비동기적으로 로드하고 표시하는 위젯입니다.
///
/// [ConsumerWidget]으로 구현되어 [scheduleProvider]를 통해 일정 데이터의
/// 로딩, 성공, 오류 상태를 감지하고 각 상태에 맞는 UI를 렌더링합니다.
/// 일정이 있을 경우 각 일정을 별도의 카드로 표시합니다.
class UpcomingEventsCard extends ConsumerWidget {
  /// [UpcomingEventsCard]의 생성자입니다.
  ///
  /// @param key 위젯의 고유 식별자입니다.
  const UpcomingEventsCard({super.key});

  /// 위젯의 UI를 빌드합니다.
  ///
  /// @param context 위젯 트리에서의 위치 정보를 담은 [BuildContext].
  /// @param ref 프로바이더를 읽고 상호작용하기 위한 [WidgetRef].
  /// @return 빌드된 [Widget].
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesAsyncValue = ref.watch(scheduleProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // "다가오는 일정" 제목
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 8.0, left: 4.0),
          child: Text(
            AppLocalizations.of(context)!.upcomingEventsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        // 비동기 상태(로딩, 오류, 데이터)에 따라 다른 위젯을 렌더링합니다.
        schedulesAsyncValue.when(
          // 데이터 로딩 중일 때 원형 진행 표시기를 보여줍니다.
          loading: () => const Center(child: CircularProgressIndicator()),
          // 오류가 발생했을 때 오류 메시지를 보여줍니다.
          error: (err, stack) => Center(child: Text('Error: $err')),
          // 데이터 로딩에 성공했을 때 일정 목록 또는 "일정 없음" 메시지를 보여줍니다.
          data: (schedules) {
            if (schedules.isEmpty) {
              // 일정이 없을 때 표시할 카드
              return Card(
                margin: EdgeInsets.zero,
                color: Theme.of(context).colorScheme.surface,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.noUpcomingEvents,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              );
            }
            // 일정이 있을 때 각 일정을 별도의 카드로 표시합니다.
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: schedules.map((schedule) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  color: Theme.of(context).colorScheme.surface,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "${AppLocalizations.of(context)!.upcomingEventsDateTitle}: ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: DateFormat('yyyy-MM-dd')
                                      .format(schedule.date)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "${AppLocalizations.of(context)!.upcomingEventsLocationTitle}: ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              TextSpan(text: schedule.location),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "${AppLocalizations.of(context)!.upcomingEventsNotesTitle}: ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              TextSpan(text: schedule.notes),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}