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
  late GameConfig currentSelectedConfig;
  late MineGameVariant currentSelectedVariant;

  late List<StatelessWidget> configTiles;
  late List<StatelessWidget> variantTiles;

  void setCurrentConfig(GameConfig c) {
    currentSelectedConfig = c;
  }

  void setCurrentVariant(MineGameVariant v) {
    currentSelectedVariant = v;
  }

  void initState() {
    super.initState();

    currentSelectedConfig = widget.configs[0];
    currentSelectedVariant = widget.variants[0];

    // yes, i know, repeated code
    // but i think if i refactored this it would be uglier
    configTiles = widget.configs.map((c) => RadioListTile<GameConfig>(
      title: Text(c.toString()),
      value: c,
      groupValue: currentSelectedConfig,
      onChanged: (c) => setState(() { currentSelectedConfig = c!; })
    )).toList();

    variantTiles = widget.variants.map((v) => RadioListTile<MineGameVariant>(
      title: Text(v.toString()),
      value: v,
      groupValue: currentSelectedVariant,
      onChanged: (v) => setState(() { currentSelectedVariant = v!; })
    )).toList();
  }

  Widget build(BuildContext context) => ListView(
    children: configTiles + [ListTile()] + variantTiles
  );
}