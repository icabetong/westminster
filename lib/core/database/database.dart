import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:westminster/core/repository/profile_repository.dart';
import 'package:westminster/routes/profile/profile.dart';

class HiveDatabase {
  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(GenderAdapter());

    await ProfileRepository.open();
  }
}
