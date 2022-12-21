import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static const _currentProfile = "profileId";
  static const _music = "music";
  static const _effects = "effects";

  static Future<bool> setMusic(bool enabled) async {
    final preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(_music, enabled);
  }

  static Future<bool> setSoundEffects(bool enabled) async {
    final preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(_effects, enabled);
  }

  static Future<bool> setCurrentProfile(String? profileId) async {
    final preferences = await SharedPreferences.getInstance();
    return await preferences.setString(_currentProfile, profileId ?? '');
  }

  static Future<String?> get currentProfile async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_currentProfile);
  }

  static Future<bool> get music async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_music) ?? true;
  }

  static Future<bool> get effects async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_effects) ?? true;
  }
}
