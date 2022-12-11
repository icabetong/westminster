import 'package:westminster/core/repository/repository.dart';
import 'package:westminster/routes/game/game.dart';
import 'package:westminster/shared/reader.dart';

class QuestionRepository extends Repository<Question> {
  final reader = DefineReader<Question>();
  final List<Question> _questions = [];

  QuestionRepository() {
    onInit();
  }

  Future<void> onInit() async {
    final parsedQuestions = await reader.parse(
      DefineReader.questionsPath,
      Question.fromJson,
    );
    _questions.addAll(parsedQuestions);
  }

  @override
  List<Question> fetch() {
    return _questions;
  }

  @override
  Future put(Question data) async {
    final index = _questions
        .indexWhere((element) => data.questionId == element.questionId);
    if (index >= 0) {
      _questions[index] = data;
    } else {
      _questions.add(data);
    }
  }

  @override
  Future remove(Question data) async {
    final index = _questions
        .indexWhere((element) => data.questionId == element.questionId);
    if (index >= 0) {
      _questions.removeAt(index);
    }
  }
}
