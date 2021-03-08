import 'package:flutter/material.dart';

import 'package:mine/app/mine_game_selection.dart';
import 'package:mine/game/game_config.dart';
import 'package:mine/variant/game_variant.dart';
import 'package:mine/variant/default_game_variant.dart';

class AppDrawer extends StatelessWidget {
  final List<GameConfig> configs = [
    GameConfig('Beginner', 8, 8, 10),
    GameConfig('Intermediate', 16, 16, 40),
    GameConfig('Expert', 30, 16, 99)
  ];

  final List<GameVariant> variants = [DefaultGameVariant()];

  Widget build(BuildContext context) {
    return Drawer(
      child: MineGameSelection(configs, variants)
    );
  }
}