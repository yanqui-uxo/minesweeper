import 'dart:math';
import 'package:flutter/material.dart';
import 'game_display.dart';
import 'game_state_display.dart';
import 'package:mine/game/single_mine_game.dart';

class SingleMineGameDisplay extends GameDisplay {
  final SingleMineGame game;
  
  SingleMineGameDisplay(this.game) : super(game);

  Widget getDisplay(Point p) {
    var sq = game.board.boardMap[p];
    if (!sq.isRevealed) {
      if (sq.isFlagged) {
        return Icon(Icons.flag, color: Colors.red[900]);
      } else {
        return Text('#');
      }
    }

    if (sq.isMine) {
      return Icon(Icons.star);
    } else {
      int mineNum = game.board.getNeighborMines(p);

      if (mineNum == 0) {
        return Container();
      } else {
        return Text(mineNum.toString(), style: TextStyle(color: numberColor(mineNum)));
      }
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