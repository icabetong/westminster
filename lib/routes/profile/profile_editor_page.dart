import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/providers/profile.dart';
import 'package:westminster/routes/profile/profile.dart';
import 'package:westminster/shared/theme.dart';

class ProfileEditorPage extends ConsumerStatefulWidget {
  const ProfileEditorPage({super.key, this.profile});

  final Profile? profile;

  @override
  ConsumerState<ProfileEditorPage> createState() => _ProfileEditorPageState();
}

class _ProfileEditorPageState extends ConsumerState<ProfileEditorPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _age = 0;
  Gender _gender = Gender.male;

  void _onValidateForm() {
    // returns true if form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Profile profile = Profile(
        _name,
        _age,
        gender: _gender,
        profileId: widget.profile?.profileId,
      );
      ref.read(profileListProvider.notifier).put(profile);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).pageCreateProfile),
      ),
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
                  if (value != null) _name = value;
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
                    _age = int.parse(value);
                  }
                },
              ),
              const SizedBox(height: WestminsterTheme.mediumSpacing),
              Row(
                children: [
                  Radio<Gender>(
                    value: Gender.male,
                    groupValue: _gender,
                    onChanged: (Gender? gender) {
                      if (gender != null) {
                        setState(() {
                          _gender = gender;
                        });
                      }
                    },
                  ),
                  Text(Translations.of(context).fieldGenderMale)
                ],
              ),
              Row(
                children: [
                  Radio<Gender>(
                    value: Gender.female,
                    groupValue: _gender,
                    onChanged: (Gender? gender) {
                      if (gender != null) {
                        setState(() {
                          _gender = gender;
                        });
                      }
                    },
                  ),
                  Text(Translations.of(context).fieldGenderFemale)
                ],
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
