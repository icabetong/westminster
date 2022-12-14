import 'package:hive/hive.dart';
import 'package:westminster/routes/profile/profile.dart';
import 'package:westminster/shared/tools.dart';
part 'game.g.dart';

class Chapter {
  String locationId;
  List<Question> questions;

  Chapter(this.locationId, this.questions);

  static const _fieldLocationId = "locationId";
  static const _fieldQuestions = "questions";

  factory Chapter.fromJson(Map<String, dynamic> json) {
    Iterable questions = json[_fieldQuestions];
    return Chapter(
      json[_fieldLocationId] as String,
      List<Question>.from(questions.map(
        (question) => Question.fromJson(question),
      )),
    );
  }
}

class Question {
  late String questionId;
  String question;
  int answer;
  List<String> choices;

  Question(this.question, this.answer, this.choices, {String? questionId}) {
    this.questionId = questionId ?? randomId();
  }

  static const _fieldQuestionId = "questionId";
  static const _fieldQuestion = "question";
  static const _fieldAnswer = "answer";
  static const _fieldChoices = "choices";

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json[_fieldQuestionId] as String,
      json[_fieldQuestion] as String,
      json[_fieldAnswer] as int,
      List<String>.from(json[_fieldChoices]),
    );
  }
}

@HiveType(typeId: 3)
class GameLog extends HiveObject {
  @HiveField(0)
  late String logId;
  @HiveField(1)
  Profile profile;
  @HiveField(2)
  int score;
  @HiveField(3)
  late DateTime dateTime;

  GameLog(this.profile, this.score, {String? logId, DateTime? dateTime}) {
    this.logId = logId ?? randomId();
    this.dateTime = dateTime ?? DateTime.now();
  }
}
