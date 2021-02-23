import "dart:math";
import "package:flutter/material.dart";
import "gamestatedisplay.dart";
import "minegame.dart";

class GameDisplay extends StatefulWidget {
  final MineGame game;
  
  GameDisplay(this.game);

  Widget getDisplay(Point p) {
    var sq = game.board.boardMap[p];
    if (!sq.isRevealed) {
      if (sq.isFlagged) {
        return Text("?", style: TextStyle(color: Colors.red[900]));
      } else {
        return Text("#");
      }
    }

    if (sq.isMine) {
      return Text("*");
    } else {
      int mineNum = game.board.getNeighborMines(p);

      if (mineNum == 0) {
        return Text("");
      } else {
        Color textColor;
        switch (mineNum) {
          case 1: textColor = Colors.blue[700]; break;
          case 2: textColor = Colors.green[700]; break;
          case 3: textColor = Colors.red[700]; break;
          case 4: textColor = Colors.blue[900]; break;
          case 5: textColor = Colors.red[900]; break;
          case 6: textColor = Colors.teal[700]; break;
          case 7: textColor = Colors.black; break;
          case 8: textColor = Colors.grey[700]; break;
        }
        return Text(mineNum.toString(), style: TextStyle(color: textColor));
      }
    }
  }

  Color getBackgroundColor(Point p) {
    var sq = game.board.boardMap[p];

    if (sq.isRevealed && sq.isMine) {
      return Colors.red;
    } else {
      return Colors.grey[300];
    }
  }

  @override
  _GameDisplayState createState() => _GameDisplayState();
}

class _GameDisplayState extends State<GameDisplay> {
  GameStateDisplay stateDisplay;
  
  @override
  void initState() {
    super.initState();
    stateDisplay = GameStateDisplay(widget.game.state);
  }

  void tapSquare(int x, int y) {
    setState(() {
      widget.game.clickHandle(Point(x, y));

      if (stateDisplay.state != widget.game.state) {
        stateDisplay = GameStateDisplay(widget.game.state);
      }
    });
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
              child: widget.getDisplay(Point(x, y)),
              fit: BoxFit.contain
            ),
            color: widget.getBackgroundColor(Point(x, y))
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

    return Column(
      children: [
        stateDisplay,
        Expanded(
          child: Center(
            child: AspectRatio(
              child: Column(children: children),
              aspectRatio: widget.game.board.width / widget.game.board.height
            )
          )
        )
      ]
    );
  }
}