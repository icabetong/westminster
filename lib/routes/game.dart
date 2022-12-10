import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/providers/player.dart';
import 'package:westminster/shared/theme.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  @override
  Widget build(BuildContext context) {
    final player = ref.watch(playerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: WestminsterTheme.normalPadding,
          child: Column(
            children: [Text(player!.name)],
          ),
        ),
      ),
    );
  }
}
