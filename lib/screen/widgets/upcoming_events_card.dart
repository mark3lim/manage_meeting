import 'package:flutter/material.dart';
import 'package:manage_meeting/generated/l10n/app_localizations.dart';

/// [UpcomingEventsCard]는 다가오는 일정을 표시하는 카드 형태의 위젯입니다.
class UpcomingEventsCard extends StatelessWidget {
  /// [UpcomingEventsCard]의 생성자입니다.
  const UpcomingEventsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16.0),
      color: Theme.of(context).colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.upcomingEventsTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // TODO: 다가오는 일정 목록을 여기에 구현합니다.
          ],
        ),
      ),
    );
  }
}
