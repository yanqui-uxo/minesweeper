import "package:flutter/material.dart";
import "gameconfig.dart";
import "minegame.dart";
import "gamedisplay.dart";
import "gamestatedisplay.dart";

class MineApp extends StatefulWidget {
  static List<GameConfig> configs = [
    GameConfig("Beginner", 8, 8, 10),
    GameConfig("Intermediate", 16, 16, 40),
    GameConfig("Expert", 30, 16, 99)
  ];

  State<MineApp> createState() => _MineAppState();
}

class _MineAppState extends State<MineApp> {
  GameConfig config = MineApp.configs[0];
  MineGame game;
  GameStateDisplay stateDisplay;

  _MineAppState() {
    game = MineGame.config(config);
  }
  
  void restart(GameConfig c) {
    setState(() {
      config = c;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(config.toString())),
      drawer: Drawer(
        child: ListView(
          children: MineApp.configs.map(
            (c) => ListTile(
              title: Text(c.toString()),
              onTap: () { restart(c); Navigator.pop(context); }
            )
          ).toList()
        )
      ),

      body: GameDisplay(MineGame.config(config))
    );
  }
}