import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/providers/question.dart';
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
  List<Question> questions = [];
  Question? question;

  @override
  void initState() {
    super.initState();
    questions = ref.read(questionsProvider);
    if (questions.isNotEmpty) {
      question = questions[0];
    }
  }

  @override
  Widget build(BuildContext context) {
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
        if (question?.answer == index) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Correct!')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Wrong!')));
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const FinishedGamePage(),
          ),
        );
      }
    }

    Widget createQuestionnaire() {
      if (question == null) return Container();

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: WestminsterTheme.normalPadding,
              child: Text(question!.question),
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
      appBar: AppBar(title: Text(widget.location.name), actions: [
        IconButton(
          icon: const Icon(Icons.logout_outlined),
          onPressed: onInvokeConfirm,
        )
      ]),
      body: Padding(
        padding: WestminsterTheme.normalPadding,
        child: createQuestionnaire(),
      ),
    );
  }
}
