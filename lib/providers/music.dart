import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final musicControlProvider = StateProvider<AssetsAudioPlayer>((ref) {
  Future<void> init(AssetsAudioPlayer player) async {
    await player.open(
      Audio('assets/music.mp3'),
      loopMode: LoopMode.single,
      autoStart: false,
    );
  }

  final player = AssetsAudioPlayer.newPlayer();
  init(player);
  return player;
});
