import "dart:math";
import 'singlemineboard.dart';
import 'gameconfig.dart';
import "minegame.dart";

class SingleMineGame extends MineGame {
  final SingleMineBoard board;
  GameState state = GameState.play;
  bool minesPlaced = false;

  SingleMineGame(int width, int height, int mines) : board = SingleMineBoard(width, height, mines);
  SingleMineGame.config(GameConfig conf) : this(conf.width, conf.height, conf.mines);

  List<Point> pickRandomPoints(int n, Point safePoint) {
    List<Point> points = board.boardMap.keys.toList();
    points.remove(safePoint);
    points.shuffle();

    return points.take(n).toList();
  }

  void flag(Point p) {
    board.boardMap[p].isFlagged ^= true;
  }

  void placeMines(Point safePoint) {
    for (Point p in pickRandomPoints(board.mines, safePoint)) {
      board.boardMap[p].isMine = true;
    }
  }
}