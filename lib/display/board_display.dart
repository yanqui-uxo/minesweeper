import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mine/game/game.dart';

abstract class BoardDisplay<T extends Game> extends StatefulWidget {
  T get game;

  Widget get flag => Icon(Icons.flag, color: Colors.red[900]);
  Widget get emptySquare => Text('#');
  Widget get mine => Icon(Icons.star);

  FittedBox fitWrap(Widget w) => FittedBox(child: w, fit: BoxFit.contain);

  Widget getDisplay(Point p);

  Color defaultBackgroundColor(Point p) {
    var sq = game.board.boardMap[p]!;

    if (sq.isRevealed && sq.isMine) {
      return Colors.red;
    } else {
      return Colors.grey[300]!;
    }
  }

  Color getBackgroundColor(Point p) {
    return defaultBackgroundColor(p);
  }

  Color numberColor(int num) {
    switch (num) {
      case 1: return Colors.blue[700]!;
      case 2: return Colors.green[700]!;
      case 3: return Colors.red[700]!;
      case 4: return Colors.blue[900]!;
      case 5: return Colors.red[900]!;
      case 6: return Colors.teal[700]!;
      case 7: return Colors.black;
      case 8: return Colors.grey[700]!;
      default: return Colors.black;
    }
  }

  Widget numWidget(int num) {
    if (num != 0) {
      return Text(num.toString(), style: TextStyle(color: numberColor(num)));
    } else {
      return Container();
    }
  }
}

abstract class BoardDisplayState<T extends BoardDisplay> extends State<T> {
  Widget build(BuildContext context) {
    Widget _generateRow(int y) {
      var children = List.generate(
        widget.game.board.width,
        (int x) => Expanded(
          child: GestureDetector(
            child: Container(
              child: widget.getDisplay(Point(x, y)),
              color: widget.getBackgroundColor(Point(x, y))
            ),

            onTap: () => (setState(() => widget.game.clickHandle(Point(x, y)))),
            onLongPress: () => setState(() => widget.game.flag(Point(x, y))),
            behavior: HitTestBehavior.translucent
          )
        )
      );
      return Row(children: children, crossAxisAlignment: CrossAxisAlignment.stretch);
    }

    var colChildren = List.generate(widget.game.board.height, (int y) => Expanded(child: _generateRow(y)));

    return AspectRatio(
      child: Column(
        children: colChildren
      ),
      aspectRatio: widget.game.board.width / widget.game.board.height,
    );
  }
}