import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static const _currentProfile = "profileId";

  static Future<bool> setCurrentProfile(String profileId) async {
    final preferences = await SharedPreferences.getInstance();
    return await preferences.setString(_currentProfile, profileId);
  }

  static Future<String?> get getCurrentProfile async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_currentProfile);
  }
}
