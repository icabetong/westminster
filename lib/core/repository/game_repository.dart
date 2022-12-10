import 'package:hive/hive.dart';
import 'package:westminster/core/repository/repository.dart';
import 'package:westminster/routes/game/game.dart';

class GameRepository extends Repository<GameLog> {
  static const _boxName = "leaderboard";
  final _box = Hive.box<GameLog>(_boxName);
  List<GameLog> _gamelogs = [];

  GameRepository() {
    _gamelogs = _box.values.toList();
  }

  static Future<bool> open() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<GameLog>(_boxName);
    }
    return true;
  }

  @override
  List<GameLog> fetch() {
    return _gamelogs;
  }

  @override
  Future put(GameLog data) async {
    final index =
        _gamelogs.indexWhere((element) => data.logId == element.logId);
    if (index > -1) {
      _gamelogs[index] = data;
    } else {
      _gamelogs.add(data);
    }

    await _box.clear();
    return _box.addAll(_gamelogs);
  }

  @override
  Future remove(GameLog data) async {
    _gamelogs.removeWhere((gameLog) => data.logId == gameLog.logId);
    await _box.clear();
    return await _box.addAll(_gamelogs);
  }
}
