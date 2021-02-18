import "dart:math";
import "package:flutter/material.dart";
import "minegame.dart";

class GameDisplay extends StatefulWidget {
  final MineGame game;
  final Map<Point, String> displays = {};
  
  GameDisplay(this.game);

  String getDisplay(Point p) {
    if (!game.board.boardMap[p].isRevealed) return "";

    if (game.board.boardMap[p].isMine) {
      return "*";
    } else {
      return game.board.getNeighborMines(p).toString();
    }
  }

  @override
  _GameDisplayState createState() => _GameDisplayState();
}

class _GameDisplayState extends State<GameDisplay> {
  void tapSquare(int x, int y) {
    setState(() => widget.game.reveal(Point(x, y)));
  }

  Widget _generateRow(int y) {
    var children = List.generate(
      widget.game.board.width,
      (int x) => Expanded(
        child: GestureDetector(
          child: Container(
            child: FittedBox(
              child: Text(widget.getDisplay(Point(x, y))),
              fit: BoxFit.contain
            ),
            color: Colors.red
          ),

          onTap: () => tapSquare(x, y),
          behavior: HitTestBehavior.translucent
        )
      )
    );
    return Row(children: children, crossAxisAlignment: CrossAxisAlignment.stretch);
  }

  @override
  Widget build(BuildContext buildContext) {
    var children = List.generate(widget.game.board.height, (int y) => Expanded(child: _generateRow(y)));

    return AspectRatio(
      child: Column(children: children),
      aspectRatio: widget.game.board.width / widget.game.board.height
    );
  }
}