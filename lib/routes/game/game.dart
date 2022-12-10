import 'package:hive/hive.dart';
import 'package:westminster/routes/profile/profile.dart';
import 'package:westminster/shared/tools.dart';
part 'game.g.dart';

class Question {
  late String questionId;
  String question;
  int answer;
  List<String> choices;

  Question(this.question, this.answer, this.choices, {String? questionId}) {
    this.questionId = questionId ?? randomId();
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
