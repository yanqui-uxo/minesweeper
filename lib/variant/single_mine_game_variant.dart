import 'package:mine/game/game_config.dart';
import 'package:mine/game/single_mine_game.dart';
import 'package:mine/variant/mine_game_variant.dart';

class SingleMineGameVariant implements MineGameVariant<SingleMineGame> {
  SingleMineGame makeGame(GameConfig conf) => SingleMineGame(conf);
  String toString() => "Single mine maximum per square";
}