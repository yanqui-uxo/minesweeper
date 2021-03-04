import 'package:flutter/material.dart';
import 'package:mine/game/game_config.dart';
import 'package:mine/variant/mine_game_variant.dart';

class MineGameSelection extends StatefulWidget {
  final List<GameConfig> configs;
  final List<MineGameVariant> variants;

  MineGameSelection(this.configs, this.variants);

  _MineGameSelectionState createState() => _MineGameSelectionState();
}

class _MineGameSelectionState extends State<MineGameSelection> {
  GameConfig currentSelectedConfig;
  MineGameVariant currentSelectedVariant;

  List configTiles;
  List variantTiles;

  void setCurrentConfig(GameConfig c) {
    currentSelectedConfig = c;
  }

  void setCurrentVariant(MineGameVariant v) {
    currentSelectedVariant = v;
  }

  List<RadioListTile<T>> generateListTiles<T>(List<T> things, T groupValue, Function f) =>
    things.map((t) => RadioListTile(
      title: Text(t.toString()),
      value: t,
      groupValue: groupValue,
      onChanged: (t) => Function.apply(f, [t])
    ));

  void initState() {
    super.initState();

    currentSelectedConfig = widget.configs[0];
    currentSelectedVariant = widget.variants[0];

    configTiles = generateListTiles(widget.configs, currentSelectedConfig, setCurrentConfig);
    variantTiles = generateListTiles(widget.variants, currentSelectedVariant, setCurrentVariant);
  }

  Widget build(BuildContext context) => ListView(
    children: configTiles + [ListTile()] + variantTiles
  );
}