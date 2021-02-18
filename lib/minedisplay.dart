import "dart:math";
import "package:flutter/material.dart";
import "minegame.dart";

class GameDisplay extends StatefulWidget {
  final MineGame game;
  final Map<Point, String> displays = {};
  
  GameDisplay(this.game);

  String getDisplay(Point p) {
    var sq = game.board.boardMap[p];
    if (!sq.isRevealed) {
      if (sq.isFlagged) {
        return "?";
      } else {
        return "#";
      }
    }

    if (sq.isMine) {
      return "*";
    } else {
      int mineNum = game.board.getNeighborMines(p);

      if (mineNum == 0) {
        return "";
      } else {
        return mineNum.toString();
      }
    }
  }

  @override
  _GameDisplayState createState() => _GameDisplayState();
}

class _GameDisplayState extends State<GameDisplay> {
  void tapSquare(int x, int y) {
    setState(() => widget.game.clickHandle(Point(x, y)));
  }

  void flag(int x, int y) {
    setState(() => {
      widget.game.board.boardMap[Point(x, y)].isFlagged ^= true
    });
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
            color: Colors.grey
          ),

          onTap: () => tapSquare(x, y),
          onLongPress: () => flag(x, y),
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