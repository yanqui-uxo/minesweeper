import "dart:math";

class Square {
  bool isMine;
  bool isRevealed = false;
  bool isFlagged = false;

  Square(this.isMine);
}

class Board {
  final int width;
  final int height;
  final int mines;

  final Map<Point, Square> boardMap = {};

  Board(this.width, this.height, this.mines) {
    initBoardMap();
  }

  void initBoardMap() {
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        boardMap[Point(x, y)] = Square(false);
      }
    }
  }

  List<Point> getNeighbors(Point p) {
    List<Point> neighbors = [];

    for (int dx in [-1, 0, 1]) {
      for (int dy in [-1, 0, 1]) {
        if (dx != 0 || dy != 0) {
          var newPoint = Point(p.x + dx, p.y + dy);
          if (
            newPoint.x >= 0 && newPoint.x < width &&
            newPoint.y >= 0 && newPoint.y < height
          ) {
            neighbors.add(newPoint);
          }
        }
      }
    }

    return neighbors;
  }

  int getNeighborMines(Point p) {
    int mineCount = 0;
    for (Point np in getNeighbors(p)) {
      if (boardMap[np].isMine) {
        mineCount++;
      }
    }
    return mineCount;
  }

  // returns success
  bool reveal(Point p) {
    if (!boardMap[p].isRevealed) {
      boardMap[p].isRevealed = true;
      return true;
    } else {
      return false;
    }
  }
}