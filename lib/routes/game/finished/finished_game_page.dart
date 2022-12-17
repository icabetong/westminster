import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/routes/game/game_page.dart';
import 'package:westminster/routes/locations/locations.dart';
import 'package:westminster/shared/theme.dart';

class FinishedGamePage extends ConsumerStatefulWidget {
  const FinishedGamePage({
    super.key,
    required this.locationId,
    required this.totalPoints,
    required this.earnedPoints,
  });

  final int earnedPoints;
  final int totalPoints;
  final String locationId;

  @override
  ConsumerState<FinishedGamePage> createState() => _FinishedGamePageState();
}

class _FinishedGamePageState extends ConsumerState<FinishedGamePage> {
  String getGreeting() {
    if (widget.totalPoints == widget.earnedPoints) {
      return Translations.of(context).pageGameFinishedPerfect;
    } else if (widget.earnedPoints >= widget.totalPoints / 2 &&
        widget.earnedPoints < widget.totalPoints) {
      return Translations.of(context).pageGameFinishedAverage;
    } else {
      return Translations.of(context).pageGameFinishedLow;
    }
  }

  void onProceedToNextLocation() {
    final locations = Location.getLocations(context);
    final index = locations
        .indexWhere((element) => element.locationId == widget.locationId);
    if (index >= 0) {
      final nextLocation = locations[index + 1];
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => GamePage(location: nextLocation),
          ),
          (route) => false);
    }
  }

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
            Text(
              getGreeting(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: WestminsterTheme.mediumSpacing),
            Text(
              Translations.of(context).earnedPoints(widget.earnedPoints),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: WestminsterTheme.mediumSpacing),
            ElevatedButton(
              onPressed: onProceedToNextLocation,
              child: Text(Translations.of(context).buttonNextLocation),
            ),
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
