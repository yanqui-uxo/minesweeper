import "dart:math";
import "board.dart";
import "gameconfig.dart";

enum GameState {
  play,
  win,
  loss
}

class MineGame {
  final Board board;
  GameState state = GameState.play;
  bool minesPlaced = false;

  MineGame(int width, int height, int mines) : board = Board(width, height, mines);
  MineGame.config(GameConfig conf) : this(conf.width, conf.height, conf.mines);

  void placeMines(Point safePoint) {
    List<Point> points = board.boardMap.keys.toList();

    points.remove(safePoint);

    points.shuffle();

    for (Point p in points.take(board.mines)) {
      board.boardMap[p].isMine = true;
    }
  }

  // returns success
  bool reveal(Point p) {
    if (!board.reveal(p)) return false;

    if (!board.boardMap[p].isMine && board.getNeighborMines(p) == 0) {
      for (Point np in board.getNeighbors(p)) {
        reveal(np);
      }
    }

    return true;
  }

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
    }
    return true;
  }
}