import "package:flutter/material.dart";
import "minedisplay.dart";
import "minegame.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MineGame game = MineGame(8, 8, 10);
    return MaterialApp(home: Scaffold(body: GameDisplay(game)));
  }
}