import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:westminster/routes/leaderboard.dart';
import 'package:westminster/routes/player.dart';
import 'package:westminster/routes/settings.dart';
import 'package:westminster/shared/theme.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<bool?> _onConfirmExit() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).dialogConfirmExitTitle),
          content: Text(Translations.of(context).dialogConfirmExitBody),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(Translations.of(context).buttonExit),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(Translations.of(context).buttonCancel),
            )
          ],
        );
      },
    );
  }

  void _onStartGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const PlayerPage(),
      ),
    );
  }

  void _onStartTutorial() {}
  void _onCheckLeaderboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LeaderboardPage(),
      ),
    );
  }

  void _onInvokeSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const SettingsPage(),
      ),
    );
  }

  Future<void> _onExit() async {
    final bool confirmation = await _onConfirmExit() ?? false;
    if (confirmation) {
      SystemChannels.platform.invokeListMethod('SystemNavigator.pop');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: WestminsterTheme.normalPadding,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Translations.of(context).appName,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: WestminsterTheme.mediumSpacing),
              ElevatedButton.icon(
                onPressed: _onStartGame,
                icon: const Icon(Icons.military_tech_outlined),
                label: Text(Translations.of(context).mainMenuStart),
              ),
              ElevatedButton.icon(
                onPressed: _onStartTutorial,
                icon: const Icon(Icons.school_outlined),
                label: Text(Translations.of(context).mainMenuTutorial),
              ),
              ElevatedButton.icon(
                onPressed: _onCheckLeaderboard,
                icon: const Icon(Icons.leaderboard_outlined),
                label: Text(Translations.of(context).mainMenuLeaderboard),
              ),
              ElevatedButton.icon(
                onPressed: _onInvokeSettings,
                icon: const Icon(Icons.settings_outlined),
                label: Text(Translations.of(context).mainMenuSettings),
              ),
              ElevatedButton.icon(
                onPressed: _onExit,
                icon: const Icon(Icons.exit_to_app_outlined),
                label: Text(Translations.of(context).mainMenuQuit),
              )
            ],
          ),
        ),
      ),
    );
  }
}
