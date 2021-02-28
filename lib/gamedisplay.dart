import "dart:math";
import "package:flutter/material.dart";
import "minegame.dart";

abstract class GameDisplay extends StatefulWidget {
  final MineGame game;
  GameDisplay(this.game);

  Widget getDisplay(Point p);

  Color getBackgroundColor(Point p);
}

abstract class GameDisplayState<T extends GameDisplay> extends State<T> {
  Widget generateBoardDisplay() {
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
      aspectRatio: widget.game.board.width / widget.game.board.height
    );
  }
}