import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:westminster/shared/theme.dart';

class FinishedGamePage extends StatefulWidget {
  const FinishedGamePage({super.key});

  @override
  State<FinishedGamePage> createState() => _FinishedGamePageState();
}

class _FinishedGamePageState extends State<FinishedGamePage> {
  void onNavigateToMainMenu() {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: WestminsterTheme.normalPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: onNavigateToMainMenu,
              child: Text(Translations.of(context).buttonExit),
            )
          ],
        ),
      ),
    );
  }
}
