import 'package:mine/display/game_display.dart';
import 'package:mine/game/game_config.dart';
import 'package:mine/game/game.dart';

abstract class GameVariant<T extends GameConfig> {
  GameDisplay makeDisplay(T conf);
  
  String toString();
}