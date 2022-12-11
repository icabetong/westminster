import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/core/database/database.dart';
import 'package:westminster/routes/leaderboard/leaderboard_page.dart';
import 'package:westminster/routes/main.dart';
import 'package:westminster/routes/settings/settings_page.dart';
import 'package:westminster/shared/theme.dart';

void main() async {
  await HiveDatabase.init();
  runApp(const ProviderScope(child: Westminster()));
}

class Westminster extends StatelessWidget {
  const Westminster({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: WestminsterTheme.getTheme(),
      home: const MainPage(),
      localizationsDelegates: const [
        Translations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('en', '')],
      onGenerateTitle: (context) => Translations.of(context).appName,
      initialRoute: 'home',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'leaderboard':
            return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) => const LeaderboardPage(),
            );
          case 'settings':
            return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) => const SettingsPage(),
            );
          case 'home':
          default:
            return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) => const MainPage(),
            );
        }
      },
    );
  }
}
