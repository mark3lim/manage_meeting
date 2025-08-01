import 'package:flutter/material.dart';
import 'package:manage_meeting/generated/l10n/app_localizations.dart';

/// [UpcomingEventsCard]는 다가오는 일정을 표시하는 카드 형태의 위젯입니다.
class UpcomingEventsCard extends StatelessWidget {
  /// [UpcomingEventsCard]의 생성자입니다.
  const UpcomingEventsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 독립된 제목
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 8.0, left: 4.0),
          child: Text(
            AppLocalizations.of(context)!.upcomingEventsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        // 카드 컨테이너
        Card(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO: 다가오는 일정 목록을 여기에 구현합니다.
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: "${AppLocalizations.of(context)!.upcomingEventsDateTitle}: ",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: '2025-08-15'),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: "${AppLocalizations.of(context)!.upcomingEventsLocationTitle}: ",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: '독립문 앞 스타벅스'),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: "${AppLocalizations.of(context)!.upcomingEventsNotesTitle}: ",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(
                          text: '이것은 테스트용 텍스트입니다. 라임 지리노!'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
