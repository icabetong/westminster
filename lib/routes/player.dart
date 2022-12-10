import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/providers/player.dart';
import 'package:westminster/routes/game.dart';
import 'package:westminster/shared/theme.dart';
import 'package:westminster/shared/tools.dart';

enum Gender { male, female }

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

class Player {
  late String playerId;
  String name;
  int age;
  Gender gender = Gender.male;

  Player(this.name, this.age, {String? playerId, Gender? gender}) {
    this.playerId = playerId ?? randomId();
    if (gender != null) {
      this.gender = gender;
    }
  }
}

class PlayerPage extends ConsumerStatefulWidget {
  const PlayerPage({super.key});

  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  int age = 0;

  void _onValidateForm() {
    // returns true if form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final Player player = Player(name, age);
      ref.read(playerProvider.notifier).updatePlayer(player);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const GamePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: WestminsterTheme.normalPadding,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: Translations.of(context).fieldName,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Translations.of(context).feedbackEmptyName;
                  }

                  return null;
                },
                onSaved: (value) {
                  if (value != null) name = value;
                },
              ),
              const SizedBox(height: WestminsterTheme.normalSpacing),
              TextFormField(
                decoration: InputDecoration(
                  labelText: Translations.of(context).fieldAge,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Translations.of(context).feedbackEmptyAge;
                  }

                  try {
                    int.parse(value);
                  } catch (error) {
                    return Translations.of(context).feedbackInvalidAge;
                  }

                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    age = int.parse(value);
                  }
                },
              ),
              const SizedBox(height: WestminsterTheme.normalSpacing),
              ElevatedButton(
                onPressed: _onValidateForm,
                child: Text(Translations.of(context).buttonContinue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
