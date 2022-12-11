import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/core/repository/question_repository.dart';
import 'package:westminster/providers/leaderboard.dart';
import 'package:westminster/providers/profile.dart';
import 'package:westminster/routes/game/finished/finished_game_page.dart';
import 'package:westminster/routes/game/game.dart';
import 'package:westminster/routes/locations/locations.dart';
import 'package:westminster/shared/theme.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key, required this.location});

  final Location location;

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  ScaffoldFeatureController? _featureController;
  int score = 0;
  List<Question> questions = [];
  Question? question;

  @override
  void initState() {
    super.initState();
    onPrepare();
  }

  Future<void> onPrepare() async {
    final repository = await QuestionRepository.init();
    final locationId = widget.location.locationId;

    Map<String, List<Question>> locationQuestions = {};
    repository.fetch().forEach((chapter) {
      locationQuestions[chapter.locationId] = chapter.questions;
    });

    final List<Question> questionsFromChapter =
        locationQuestions[locationId]?.toList() ?? [];

    if (questionsFromChapter.isNotEmpty) {
      questions = questionsFromChapter;
      setState(() => question = questionsFromChapter[0]);
    }
  }

  void createLog() {
    final logNotifier = ref.read(leaderboardProvider.notifier);
    final profileNotifier = ref.read(currentProfileProvider.notifier);
    final profile = ref.read(currentProfileProvider);
    if (profile != null) {
      final locations = profile.locations;
      if (!locations.contains(widget.location.locationId)) {
        locations.add(widget.location.locationId);

        profile.locations = locations;
        profileNotifier.change(profile);
      }

      final GameLog gameLog = GameLog(profile, score);
      logNotifier.put(gameLog);
    }
  }

  Future<bool?> onConfirmTerminate() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).dialogTerminateGameTitle),
          content: Text(Translations.of(context).dialogTerminateGameBody),
          actions: [
            TextButton(
              child: Text(Translations.of(context).buttonExit),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
              child: Text(Translations.of(context).buttonCancel),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
    return null;
  }

  Future onInvokeConfirm() async {
    final confirm = await onConfirmTerminate() ?? false;
    if (confirm && mounted) Navigator.pop(context);
  }

  void onCheckResponse(String choice) {
    final index = question?.choices.indexOf(choice) ?? -1;
    if (index >= 0) {
      _featureController?.close();
      if (question?.answer == index) {
        _featureController = ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: WestminsterTheme.primary,
            content: Text(Translations.of(context).feedbackGameCorrect),
          ),
        );
        setState(() => score++);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: WestminsterTheme.error,
            content: Text(Translations.of(context).feedbackGameWrong),
          ),
        );
      }
    }

    final questionIndex =
        questions.indexWhere((q) => q.questionId == question?.questionId);
    if (questionIndex < 0) throw StateError("Question is not in the stack!");

    if (questionIndex + 1 < questions.length) {
      setState(() {
        question = questions[questionIndex + 1];
      });
    } else {
      // end the game
      createLog();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const FinishedGamePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget createQuestionnaire() {
      if (question == null) return Container();

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: WestminsterTheme.normalPadding,
              child: Container(
                constraints: const BoxConstraints(minHeight: 128.0),
                child: Text(question!.question),
              ),
            ),
          ),
          const SizedBox(height: WestminsterTheme.mediumSpacing),
          ...question!.choices.map((choice) {
            return OutlinedButton(
                onPressed: () => onCheckResponse(choice), child: Text(choice));
          })
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Translations.of(context).score(score),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: onInvokeConfirm,
          )
        ],
      ),
      body: Padding(
        padding: WestminsterTheme.normalPadding,
        child: createQuestionnaire(),
      ),
    );
  }
}
