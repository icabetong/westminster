import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/routes/player.dart';

class PlayerNotifier extends StateNotifier<Player?> {
  PlayerNotifier() : super(null);

  updatePlayer(Player player) {
    state = player;
  }
}

final playerProvider = StateNotifierProvider<PlayerNotifier, Player?>((ref) {
  return PlayerNotifier();
});
