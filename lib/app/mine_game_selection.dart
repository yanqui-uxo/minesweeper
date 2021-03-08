import 'package:flutter/material.dart';
import 'package:mine/game/game_config.dart';
import 'package:mine/variant/game_variant.dart';

class MineGameSelection extends StatefulWidget {
  final List<GameConfig> configs;
  final List<GameVariant> variants;

  MineGameSelection(this.configs, this.variants);

  _MineGameSelectionState createState() => _MineGameSelectionState();
}

class _MineGameSelectionState extends State<MineGameSelection> {
  late GameConfig currentSelectedConfig;
  late GameVariant currentSelectedVariant;

  void setCurrentConfig(GameConfig c) {
    currentSelectedConfig = c;
  }

  void setCurrentVariant(GameVariant v) {
    currentSelectedVariant = v;
  }

  void initState() {
    super.initState();

    currentSelectedConfig = widget.configs[0];
    currentSelectedVariant = widget.variants[0];
  }

  Widget build(BuildContext context) {
    // yes i know, repeated code... but fixing that would result in an uglier problem
    List<Widget> configTiles = widget.configs.map((c) => RadioListTile<GameConfig>(
      title: Text(c.toString()),
      value: c,
      groupValue: currentSelectedConfig,
      onChanged: (c) => setState(() { currentSelectedConfig = c!; })
    )).toList().cast<Widget>();

    List<Widget> variantTiles = widget.variants.map((v) => RadioListTile<GameVariant>(
      title: Text(v.toString()),
      value: v,
      groupValue: currentSelectedVariant,
      onChanged: (v) => setState(() { currentSelectedVariant = v!; })
    )).toList().cast<Widget>();

    print(configTiles.runtimeType);

    return ListView(
      children: configTiles + [ListTile()] + variantTiles
    );
  }
}