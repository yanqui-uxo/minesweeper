import 'dart:math';

import 'package:mine/board/multi_mine_board.dart';
import 'package:mine/game/game.dart';
import 'package:mine/game/multi_mine_game_config.dart';

class MultiMineGame extends Game {
  final MultiMineBoard board;

  final List<int> validMineNums;
  List<int> get validFlags => [0] + validMineNums;

  MultiMineGame(MultiMineGameConfig conf) :
    board = MultiMineBoard(conf.width, conf.height, conf.mines),
    validMineNums = conf.validMineNums;

  void flag(Point p) {
    int currFlag = board.boardMap[p]!.flag;
    int currIdx = validFlags.indexOf(currFlag);
    int newIdx = (currIdx + 1) % validFlags.length;
    board.boardMap[p]!.flag = validFlags[newIdx];
  }

  void placeMine(Point p) {
    board.boardMap[p]!.mineNum = validMineNums[Random().nextInt(validMineNums.length)];
  }
}