import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/core/repository/game_repository.dart';
import 'package:westminster/routes/game/game.dart';

class LeaderboardNotifier extends StateNotifier<List<GameLog>> {
  final repository = GameRepository();
  LeaderboardNotifier() : super([]) {
    state = repository.fetch();
    sort();
  }

  put(GameLog gameLog) {
    repository.put(gameLog);
    state = [...repository.fetch()];
    sort();
  }

  remove(GameLog gameLog) {
    repository.remove(gameLog);
    state = [...repository.fetch()];
    sort();
  }

  List<GameLog> fetch() {
    return state;
  }

  void sort() {
    state.sort((curr, prev) => curr.score.compareTo(prev.score));
  }
}

final leaderboardProvider =
    StateNotifierProvider<LeaderboardNotifier, List<GameLog>>((ref) {
  return LeaderboardNotifier();
});
