import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:westminster/components/empty_view.dart';
import 'package:westminster/providers/leaderboard.dart';
import 'package:westminster/shared/theme.dart';

class LeaderboardPage extends ConsumerStatefulWidget {
  const LeaderboardPage({super.key});

  @override
  ConsumerState<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends ConsumerState<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    final logs = ref.watch(leaderboardProvider);

    Widget getAppropriateChild(bool isEmpty) {
      return isEmpty
          ? EmptyView(
              title: Translations.of(context).emptyLeaderboardTitle,
              summary: Translations.of(context).emptyLeaderboardBody,
            )
          : ListView.builder(
              itemCount: logs.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final log = logs[index];
                final rank = index + 1;

                return ListTile(
                  title: Text(log.profile.name),
                  subtitle: Text(log.dateTime.toMoment().fromNow()),
                  leading: Text(
                    rank.toString(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        log.score.toString(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(Translations.of(context).feedbackPoints)
                    ],
                  ),
                );
              },
            );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).mainMenuLeaderboard),
          centerTitle: true,
        ),
        body: getAppropriateChild(logs.isEmpty));
  }
}
