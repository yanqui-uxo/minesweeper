import 'package:mine/game/game_config.dart';
import 'package:mine/game/mine_game.dart';

abstract class MineGameVariant<T extends MineGame> {
  T makeGame(GameConfig conf);
  
  String toString();
}