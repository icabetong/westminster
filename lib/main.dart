import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/routes/main.dart';

void main() {
  runApp(const ProviderScope(child: Westminster()));
}

class Westminster extends StatelessWidget {
  const Westminster({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Westminster',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
      localizationsDelegates: const [
        Translations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('en', '')],
    );
  }
}
