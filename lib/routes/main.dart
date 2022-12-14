import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/components/main_button.dart';
import 'package:westminster/providers/music.dart';
import 'package:westminster/providers/profile.dart';
import 'package:westminster/routes/leaderboard/leaderboard_page.dart';
import 'package:westminster/routes/locations/locations_page.dart';
import 'package:westminster/routes/profile/profile_list_page.dart';
import 'package:westminster/routes/settings/settings_page.dart';
import 'package:westminster/shared/preferences.dart';
import 'package:westminster/shared/theme.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    super.initState();
    onPrepare();
  }

  Future<void> onPrepare() async {
    final musicControl = ref.read(musicControlProvider);
    final musicEnabled = await PreferenceHandler.music;

    if (!musicControl.isPlaying.value && musicEnabled) {
      musicControl.play();
    } else {
      musicControl.stop();
    }
  }

  Future<bool?> _onConfirmCreate() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).dialogNoProfileTitle),
          content: Text(Translations.of(context).dialogNoProfileBody),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(Translations.of(context).buttonContinue),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(Translations.of(context).buttonCancel),
            )
          ],
        );
      },
    );
  }

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
              onPressed: () => Navigator.pop(context, true),
              child: Text(Translations.of(context).buttonExit),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(Translations.of(context).buttonCancel),
            )
          ],
        );
      },
    );
  }

  Future<void> _onStartGame() async {
    final profile = ref.read(currentProfileProvider);
    if (profile == null) {
      final confirmCreate = await _onConfirmCreate() ?? false;
      if (confirmCreate && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const ProfileListPage(),
          ),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LocationPage(),
        ),
      );
    }
  }

  Future<void> _onNavigateToLeaderboard() async {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return const LeaderboardPage();
    }));
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
    final currentProfile = ref.watch(currentProfileProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: WestminsterTheme.normalSpacing,
            ),
            child: TextButton.icon(
              icon: const Icon(Icons.person_outline),
              label: Text(
                currentProfile != null
                    ? currentProfile.name
                    : Translations.of(context).feedbackNoProfiles,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ProfileListPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: WestminsterTheme.normalPadding,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Translations.of(context).appName,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontFamily: 'Karla',
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: WestminsterTheme.mediumSpacing),
            MainMenuButton(
              onPressed: _onStartGame,
              icon: const Icon(Icons.military_tech_outlined),
              text: Translations.of(context).mainMenuStart,
            ),
            MainMenuButton(
              onPressed: _onNavigateToLeaderboard,
              icon: const Icon(Icons.leaderboard_outlined),
              text: Translations.of(context).mainMenuLeaderboard,
            ),
            MainMenuButton(
              onPressed: _onInvokeSettings,
              icon: const Icon(Icons.settings_outlined),
              text: Translations.of(context).mainMenuSettings,
            ),
            MainMenuButton(
              onPressed: _onExit,
              icon: const Icon(Icons.exit_to_app_outlined),
              text: Translations.of(context).mainMenuQuit,
            )
          ],
        ),
      ),
    );
  }
}
