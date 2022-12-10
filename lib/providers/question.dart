import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/routes/game/game.dart';

class QuestionListNotifier extends StateNotifier<List<Question>> {
  QuestionListNotifier() : super([]) {
    state = fetch();
  }

  List<Question> fetch() {
    return [
      Question('foo', 0, ['a', 'b', 'c']),
      Question('bar', 1, ['a', 'b', 'c']),
      Question('biz', 2, ['a', 'b', 'c']),
    ];
  }
}

final questionsProvider =
    StateNotifierProvider<QuestionListNotifier, List<Question>>((ref) {
  return QuestionListNotifier();
});
