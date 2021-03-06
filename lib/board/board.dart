import 'dart:math';

abstract class Square {
  bool isRevealed = false;
  bool isMine = false;
  bool isFlagged = false;
}

abstract class Board {
  int get width;
  int get height;
  int get mines;

  Map<Point, Square> boardMap = {};

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

  // returns success
  bool reveal(Point p) {
    if (!boardMap[p]!.isRevealed) {
      boardMap[p]!.isRevealed = true;
      return true;
    } else {
      return false;
    }
  }

  int getNeighborMines(Point p);
}