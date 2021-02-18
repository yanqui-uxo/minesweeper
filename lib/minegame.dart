import "dart:math";
import "board.dart";

class MineGame {
  final Board board;
  bool loss = false;
  bool minesPlaced = false;

  MineGame(int width, int height, int mines) : board = Board(width, height, mines);

  void placeMines(Point safePoint) {
    List<Point> points = [];

    for (var k in board.boardMap.keys) {
      points.add(k);
    }
    points.remove(safePoint);

    points.shuffle();

    for (Point p in points.take(board.mines)) {
      board.boardMap[p].isMine = true;
    }
  }

  // returns success
  bool reveal(Point p) {
    if (!board.reveal(p)) return false;

    if (board.getNeighborMines(p) == 0) {
      for (Point np in board.getNeighbors(p)) {
        reveal(np);
      }
    }

    return true;
  }

  bool clickHandle(Point p) {
    var sq = board.boardMap[p];

    if (loss || sq.isFlagged) return false;

    if (!minesPlaced) {
      placeMines(p);
      minesPlaced = true;
    }
    if (!reveal(p)) return false;

    if (sq.isMine) {
      loss = true;
    }
    return true;
  }
}