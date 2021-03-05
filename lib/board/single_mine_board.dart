import 'dart:math';

import 'board.dart';

class SingleMineSquare extends Square {
  bool isMine;
  bool isFlagged = false;

  SingleMineSquare(this.isMine);
}

class SingleMineBoard extends Board {
  final int width;
  final int height;
  final int mines;

  final Map<Point, SingleMineSquare> boardMap = {};

  SingleMineBoard(this.width, this.height, this.mines) {
    initBoardMap();
  }

  void initBoardMap() {
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        boardMap[Point(x, y)] = SingleMineSquare(false);
      }
    }
  }

  void flag(Point p) {
    boardMap[p]!.isFlagged ^= true;
  }

  int getNeighborMines(Point p) {
    int mineCount = 0;
    for (Point np in getNeighbors(p)) {
      if (boardMap[np]!.isMine) {
        mineCount++;
      }
    }
    return mineCount;
  }
}