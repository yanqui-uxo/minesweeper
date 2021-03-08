import 'package:mine/game/game_config.dart';

class MultiMineGameConfig extends GameConfig {
  final List<int> validMineNums;

  MultiMineGameConfig(String title, int width, int height, int mines, this.validMineNums) :
    super(title, width, height, mines);
}