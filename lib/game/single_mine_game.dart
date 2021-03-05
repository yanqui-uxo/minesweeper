import 'dart:math';
import 'package:mine/board/single_mine_board.dart';
import 'package:mine/game/game_config.dart';
import 'package:mine/game/mine_game.dart';

class SingleMineGame extends MineGame<SingleMineBoard> {
  SingleMineBoard board;
  GameState state = GameState.play;
  bool minesPlaced = false;

  SingleMineGame(GameConfig conf) : board = SingleMineBoard(conf.width, conf.height, conf.mines);

  void flag(Point p) {
    board.boardMap[p]!.isFlagged ^= true;
  }

  void placeMines(Point safePoint) {
    for (Point p in pickRandomPoints(board.mines, safePoint)) {
      board.boardMap[p]!.isMine = true;
    }
  }
}