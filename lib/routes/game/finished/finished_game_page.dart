import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/core/repository/question_repository.dart';
import 'package:westminster/shared/theme.dart';

class FinishedGamePage extends ConsumerStatefulWidget {
  const FinishedGamePage({
    super.key,
    required this.earnedPoints,
  });

  final int earnedPoints;

  @override
  ConsumerState<FinishedGamePage> createState() => _FinishedGamePageState();
}

class _FinishedGamePageState extends ConsumerState<FinishedGamePage> {
  int totalQuestions = 0;

  @override
  void initState() {
    super.initState();
    onPrepare();
  }

  Future<void> onPrepare() async {
    final repository = await QuestionRepository.init();
    final questions = repository.fetch().map((e) => e.questions).toList();
    setState(() {
      totalQuestions = questions.length;
    });
  }

  String getGreeting() {
    if (widget.earnedPoints > totalQuestions * 0.75) {
      return Translations.of(context).pageGameFinishedPerfect;
    } else if (widget.earnedPoints <= totalQuestions * 0.75 &&
        widget.earnedPoints > totalQuestions * 0.3) {
      return Translations.of(context).pageGameFinishedAverage;
    } else {
      return Translations.of(context).pageGameFinishedLow;
    }
  }

  String getRecommendation() {
    if (widget.earnedPoints >= totalQuestions * 0.75) {
      return Translations.of(context).pageGameReadyAssessment;
    } else {
      return Translations.of(context).pageGameRetakeGame;
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
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28.0,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              getRecommendation(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: WestminsterTheme.mediumSpacing),
            Text(
              Translations.of(context).earnedPoints(
                widget.earnedPoints,
                totalQuestions,
              ),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: WestminsterTheme.mediumSpacing),
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
