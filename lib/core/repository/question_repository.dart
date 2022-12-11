import 'package:westminster/core/repository/repository.dart';
import 'package:westminster/routes/game/game.dart';
import 'package:westminster/shared/reader.dart';

class QuestionRepository extends Repository<Chapter> {
  final reader = DefineReader<Chapter>();
  final List<Chapter> _chapters = [];

  QuestionRepository._();

  Future onInit() async {
    final parsedQuestions = await reader.parse(
      DefineReader.questionsPath,
      Chapter.fromJson,
    );
    _chapters.addAll(parsedQuestions);
  }

  static Future<QuestionRepository> init() async {
    final instance = QuestionRepository._();
    await instance.onInit();
    return instance;
  }

  @override
  List<Chapter> fetch() {
    return _chapters;
  }

  @override
  Future put(Chapter data) async {
    final index = _chapters
        .indexWhere((element) => data.locationId == element.locationId);
    if (index >= 0) {
      _chapters[index] = data;
    } else {
      _chapters.add(data);
    }
  }

  @override
  Future remove(Chapter data) async {
    final index = _chapters
        .indexWhere((element) => data.locationId == element.locationId);
    if (index >= 0) {
      _chapters.removeAt(index);
    }
  }
}
