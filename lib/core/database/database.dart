import 'package:hive_flutter/hive_flutter.dart';
import 'package:westminster/core/repository/game_repository.dart';
import 'package:westminster/core/repository/profile_repository.dart';
import 'package:westminster/routes/game/game.dart';
import 'package:westminster/routes/profile/profile.dart';

class HiveDatabase {
  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(GenderAdapter());
    Hive.registerAdapter(GameLogAdapter());

    await ProfileRepository.open();
    await GameRepository.open();
  }
}
