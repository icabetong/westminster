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
  CurrentProfileNotifier() : super(null);
  final repository = ProfileRepository();

  change(Profile profile) {
    state = profile;
    PreferenceHandler.setCurrentProfile(profile.profileId);
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
