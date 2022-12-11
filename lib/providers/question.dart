import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/core/repository/question_repository.dart';
import 'package:westminster/routes/game/game.dart';

class QuestionListNotifier extends StateNotifier<List<Question>> {
  final repository = QuestionRepository();

  QuestionListNotifier() : super([]) {
    state = fetch();
  }

  List<Question> fetch() {
    return repository.fetch();
  }
}

final questionsProvider =
    StateNotifierProvider<QuestionListNotifier, List<Question>>((ref) {
  return QuestionListNotifier();
});
