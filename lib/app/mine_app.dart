import 'package:flutter/material.dart';

import 'package:mine/display/multi_mine_board_display.dart';
import 'package:mine/game/multi_mine_game_config.dart';
import 'package:mine/game/multi_mine_game.dart';

class MineApp extends StatefulWidget {
  static List<MultiMineGameConfig> configs = [
    MultiMineGameConfig('Beginner', 8, 8, 10, [1, 2]),
    MultiMineGameConfig('Intermediate', 16, 16, 40, [1, 2]),
    MultiMineGameConfig('Expert', 30, 16, 99, [1, 2])
  ];

  State<MineApp> createState() => _MineAppState();
}

class _MineAppState extends State<MineApp> {
  MultiMineGameConfig config = MineApp.configs[0];
  
  void restart(MultiMineGameConfig c) {
    setState(() {
      config = c;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(config.toString())),
      //drawer: AppDrawer(),

      body: MultiMineBoardDisplay(MultiMineGame(config))
    );
  }
}