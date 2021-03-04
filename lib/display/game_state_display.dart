import 'package:flutter/material.dart';
import 'package:mine/game/mine_game.dart';

class GameStateDisplay extends StatelessWidget {
  final MineGame game;

  GameStateDisplay(this.game);

  Widget build(BuildContext context) {
    print('building');
    switch (game.state) {
      case GameState.play: return Text('Playing'); break;
      case GameState.loss: return Text('Loss!'); break;
      case GameState.win: return Text('Victory!'); break;
    }
    return null;
  }
}