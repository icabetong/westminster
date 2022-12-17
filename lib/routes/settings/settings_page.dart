import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:westminster/providers/music.dart';
import 'package:westminster/shared/preferences.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool music = true;
  bool soundEffects = true;

  @override
  void initState() {
    super.initState();
    onPrepare();
  }

  Future<void> onPrepare() async {
    final musicPref = await PreferenceHandler.music;
    final soundEffectsPref = await PreferenceHandler.effects;
    setState(() {
      music = musicPref;
      soundEffects = soundEffectsPref;
    });
  }

  void onToggleMusic(bool? enabled) {
    final musicControl = ref.read(musicControlProvider);

    if (enabled == true) {
      if (!musicControl.isPlaying.value) musicControl.play();
    } else {
      if (musicControl.isPlaying.value) musicControl.stop();
    }

    PreferenceHandler.setMusic(enabled ?? true);
    setState(() {
      music = enabled ?? true;
    });
  }

  void onToggleSoundEffects(bool? enabled) {
    PreferenceHandler.setSoundEffects(enabled ?? true);
    setState(() {
      soundEffects = enabled ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).mainMenuSettings),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text(Translations.of(context).settingsGroupSounds),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                initialValue: music,
                onToggle: onToggleMusic,
                title: Text(Translations.of(context).settingsMusic),
              ),
              SettingsTile.switchTile(
                initialValue: soundEffects,
                onToggle: onToggleSoundEffects,
                title: Text(
                  Translations.of(context).settingsEffect,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
