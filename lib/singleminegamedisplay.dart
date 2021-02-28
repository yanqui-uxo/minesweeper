import "dart:math";
import "package:flutter/material.dart";
import "gamedisplay.dart";
import 'gamestatedisplay.dart';
import 'singleminegame.dart';

class SingleMineGameDisplay extends GameDisplay {
  final SingleMineGame game;
  
  SingleMineGameDisplay(this.game) : super(game);

  Widget getDisplay(Point p) {
    var sq = game.board.boardMap[p];
    if (!sq.isRevealed) {
      if (sq.isFlagged) {
        return Icon(Icons.flag, color: Colors.red[900]);
      } else {
        return Text("#");
      }
    }

    if (sq.isMine) {
      return Icon(Icons.star);
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

  _SingleMineGameDisplayState createState() => _SingleMineGameDisplayState();
}

class _SingleMineGameDisplayState extends GameDisplayState<SingleMineGameDisplay> {
  Widget build(BuildContext buildContext) {
    return Column(
      children: [
        Expanded(
          child: FittedBox(
            child: GameStateDisplay(widget.game),
            fit: BoxFit.contain
          ),
          flex: 1
        ),
        Expanded(
          child: Center(
            child: generateBoardDisplay()
          ),
          flex: 19
        )
      ]
    );
  }
}