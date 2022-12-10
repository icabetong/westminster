import 'package:westminster/shared/tools.dart';

class Question {
  late String questionId;
  String question;
  int answer;
  List<String> choices;

  Question(this.question, this.answer, this.choices, {String? questionId}) {
    this.questionId = questionId ?? randomId();
  }
}
