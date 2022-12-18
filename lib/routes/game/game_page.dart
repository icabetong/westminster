import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/core/repository/question_repository.dart';
import 'package:westminster/providers/leaderboard.dart';
import 'package:westminster/providers/profile.dart';
import 'package:westminster/routes/game/finished/finished_game_page.dart';
import 'package:westminster/routes/game/game.dart';
import 'package:westminster/routes/locations/locations.dart';
import 'package:westminster/shared/preferences.dart';
import 'package:westminster/shared/theme.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key, required this.location});

  final Location location;

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  late Location currentLocation;
  bool isSoundEffectsEnabled = true;
  int score = 0;
  List<Question> questions = [];
  Question? question;

  @override
  void initState() {
    super.initState();
    currentLocation = widget.location;
    onPrepare(currentLocation);
  }

  Future<void> onPrepare(Location location) async {
    isSoundEffectsEnabled = await PreferenceHandler.effects;
    final repository = await QuestionRepository.init();
    final locationId = currentLocation.locationId;

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
    final profile = ref.read(currentProfileProvider);
    if (profile != null) {
      final GameLog gameLog = GameLog(profile, score);
      logNotifier.put(gameLog);
    }
  }

  Future<bool?> onConfirmTerminate() async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).dialogTerminateGameTitle),
          content: Text(Translations.of(context).dialogTerminateGameBody),
          actions: [
            TextButton(
              child: Text(Translations.of(context).buttonExit),
              onPressed: () {
                ref.invalidate(currentProfileProvider);
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: Text(Translations.of(context).buttonCancel),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
  }

  Future onInvokeConfirm() async {
    final confirm = await onConfirmTerminate() ?? false;
    if (confirm && mounted) Navigator.pop(context);
  }

  Future<void> onCheckResponse(String choice) async {
    final index = question?.choices.indexOf(choice) ?? -1;
    if (index >= 0) {
      if (question?.answer == index) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            content: Text(Translations.of(context).feedbackGameCorrect),
            duration: const Duration(seconds: 2),
          ),
        );
        setState(() => score++);

        if (isSoundEffectsEnabled) {
          AssetsAudioPlayer.newPlayer().open(Audio('assets/correct.mp3'));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(Translations.of(context).feedbackGameWrong),
            duration: const Duration(seconds: 2),
          ),
        );

        if (isSoundEffectsEnabled) {
          AssetsAudioPlayer.newPlayer().open(Audio('assets/wrong.mp3'));
        }
      }
    }

    final locations = Location.getLocations(context);
    final currentLocationIndex = locations.indexWhere(
        (element) => element.locationId == currentLocation.locationId);

    final questionIndex =
        questions.indexWhere((q) => q.questionId == question?.questionId);
    if (questionIndex < 0) throw StateError("Question is not in the stack!");

    if (questionIndex + 1 < questions.length) {
      setState(() {
        question = questions[questionIndex + 1];
      });
    } else if (currentLocationIndex >= 0 &&
        currentLocationIndex + 1 < locations.length) {
      final newLocation = locations[currentLocationIndex + 1];

      final profileNotifier = ref.read(currentProfileProvider.notifier);
      final profile = ref.read(currentProfileProvider);

      if (profile != null) {
        final unlockedLocations = profile.locations;
        if (!unlockedLocations.contains(currentLocation.locationId)) {
          unlockedLocations.add(currentLocation.locationId);

          profile.locations = unlockedLocations;
          profileNotifier.change(profile);
        }
      }

      setState(() {
        currentLocation = newLocation;
      });

      await onPrepare(newLocation);
    } else {
      // end the game
      createLog();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FinishedGamePage(
            earnedPoints: score,
          ),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentLocation.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      question!.question,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontFamily: 'Merriweather',
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: WestminsterTheme.mediumSpacing),
          ...question!.choices.map((choice) {
            return OutlinedButton(
              onPressed: () => onCheckResponse(choice),
              child: Text(
                choice,
                style: Theme.of(context).textTheme.button?.copyWith(
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            );
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
