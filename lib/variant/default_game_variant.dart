import 'package:mine/display/game_display.dart';
import 'package:mine/display/multi_mine_game_display.dart';
import 'package:mine/game/multi_mine_game.dart';
import 'package:mine/game/multi_mine_game_config.dart';
import 'package:mine/variant/game_variant.dart';

class DefaultGameVariant<T extends MultiMineGameConfig> implements GameVariant<T> {
  GameDisplay makeDisplay(T conf) => MultiMineGameDisplay(MultiMineGame(conf));

  String toString() => "butts";
}