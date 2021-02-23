import "package:flutter/material.dart";
import "minegame.dart";

class GameStateDisplay extends StatelessWidget {
  final GameState state;

  GameStateDisplay(this.state);

  Widget build(BuildContext context) {
    switch (state) {
      case GameState.play: return Text("Playing"); break;
      case GameState.loss: return Text("Loss!"); break;
      case GameState.win: return Text("Victory!"); break;
    }
    return null;
  }
}