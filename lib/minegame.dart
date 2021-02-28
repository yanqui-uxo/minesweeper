import "dart:math";
import "board.dart";

enum GameState {
  play,
  win,
  loss
}

abstract class MineGame {
  Board board;
  GameState state = GameState.play;
  bool minesPlaced = false;

  void placeMines(Point safePoint);

  // returns success
  bool reveal(Point p) {
    Square s = board.boardMap[p];

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
    var sq = board.boardMap[p];

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

    bool win = true;
    for (var s in board.boardMap.values) {
      if (!s.isMine && !s.isRevealed) {
        win = false;
      }
    }

    if (win) state = GameState.win;

    return true;
  }
}