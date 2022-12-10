import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:hive/hive.dart';
import 'package:westminster/shared/tools.dart';
part 'profile.g.dart';

@HiveType(typeId: 0)
class Profile extends HiveObject {
  @HiveField(0)
  late String profileId;
  @HiveField(1)
  String name;
  @HiveField(2)
  int age;
  @HiveField(3)
  Gender gender = Gender.male;

  Profile(this.name, this.age, {String? profileId, Gender? gender}) {
    this.profileId = profileId ?? randomId();
    if (gender != null) {
      this.gender = gender;
    }
  }
}

@HiveType(typeId: 1)
enum Gender {
  @HiveField(0)
  male,
  @HiveField(1)
  female
}

extension GenderExtension on Gender {
  getLocalization(BuildContext context) {
    switch (this) {
      case Gender.male:
        return Translations.of(context).fieldGenderMale;
      case Gender.female:
        return Translations.of(context).fieldGenderFemale;
    }
  }
}
