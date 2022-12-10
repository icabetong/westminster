import 'package:hive/hive.dart';
import 'package:westminster/core/repository/repository.dart';
import 'package:westminster/routes/profile/profile.dart';

class ProfileRepository extends Repository<Profile> {
  static const _boxName = "profiles";
  final _box = Hive.box<Profile>(_boxName);
  List<Profile> _profiles = [];

  ProfileRepository() {
    _profiles = _box.values.toList();
  }

  static Future<bool> open() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<Profile>(_boxName);
    }
    return true;
  }

  @override
  List<Profile> fetch() {
    return _profiles;
  }

  @override
  Future put(Profile data) async {
    final index =
        _profiles.indexWhere((element) => data.profileId == element.profileId);
    if (index > -1) {
      _profiles[index] = data;
    } else {
      _profiles.add(data);
    }
    await _box.clear();
    return await _box.addAll(_profiles);
  }

  @override
  Future remove(Profile data) async {
    _profiles.removeWhere((profile) => data.profileId == profile.profileId);
    await _box.clear();
    return await _box.addAll(_profiles);
  }
}
