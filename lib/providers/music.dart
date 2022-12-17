import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final musicControlProvider = StateProvider<AssetsAudioPlayer>((ref) {
  final player = AssetsAudioPlayer.newPlayer();
  player.open(Audio('assets/music.mp3'), loopMode: LoopMode.single);

  return player;
});
