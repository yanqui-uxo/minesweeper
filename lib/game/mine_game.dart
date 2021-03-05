import 'dart:math';
import 'package:mine/board/board.dart';

enum GameState {
  play,
  win,
  loss
}

abstract class MineGame<T extends Board> {
  abstract T board;
  GameState state = GameState.play;
  bool minesPlaced = false;

  void placeMines(Point safePoint);

  List<Point> pickRandomPoints(int n, Point safePoint) {
    List<Point> points = board.boardMap.keys.toList();
    points.remove(safePoint);
    points.shuffle();

    return points.take(n).toList();
  }
  
  // returns success
  bool reveal(Point p) {
    Square s = board.boardMap[p]!;

    if (!s.isRevealed) {
      s.isRevealed = true;

      if (!s.isMine && board.getNeighborMines(p) == 0) {
        for (Point np in board.getNeighbors(p)) {
          reveal(np);
        }
      }

      return true;
    }

    return false;
  }

  void flag(Point p);

  // returns success
  bool clickHandle(Point p) {
    var sq = board.boardMap[p]!;

    if (state != GameState.play || sq.isFlagged) return false;

    if (!minesPlaced) {
      placeMines(p);
      minesPlaced = true;
    }
    if (!reveal(p)) return false;

    if (sq.isMine) {
      state = GameState.loss;
      return true;
    }

    bool win = board.boardMap.values.every((s) => s.isMine || s.isRevealed);

    if (win) state = GameState.win;

    return true;
  }
}