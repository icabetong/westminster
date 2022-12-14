import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/core/repository/profile_repository.dart';
import 'package:westminster/routes/profile/profile.dart';
import 'package:westminster/shared/preferences.dart';

class ProfileListNotifier extends StateNotifier<List<Profile>> {
  final repository = ProfileRepository();
  ProfileListNotifier() : super([]) {
    state = repository.fetch();
  }

  put(Profile profile) {
    repository.put(profile);
    state = [...repository.fetch()];
  }

  remove(Profile profile) {
    repository.remove(profile);
    state = [...repository.fetch()];
  }

  List<Profile> fetch() {
    return state;
  }
}

class CurrentProfileNotifier extends StateNotifier<Profile?> {
  final repository = ProfileRepository();
  CurrentProfileNotifier() : super(null) {
    onInit();
  }

  Future<void> onInit() async {
    final currentId = await PreferenceHandler.currentProfile;
    final profiles = repository.fetch();
    if (profiles.isNotEmpty && currentId != null && currentId.isNotEmpty) {
      final List<Profile> matched =
          profiles.where((item) => item.profileId == currentId).toList();
      if (matched.isNotEmpty) {
        state = profiles[0];
      }
    } else {
      state = null;
    }
  }

  change(Profile profile) {
    state = profile;
    PreferenceHandler.setCurrentProfile(profile.profileId);
  }

  remove() {
    state = null;
    PreferenceHandler.setCurrentProfile(null);
  }
}

final currentProfileProvider =
    StateNotifierProvider<CurrentProfileNotifier, Profile?>((ref) {
  return CurrentProfileNotifier();
});

final profileListProvider =
    StateNotifierProvider<ProfileListNotifier, List<Profile>>((ref) {
  return ProfileListNotifier();
});
