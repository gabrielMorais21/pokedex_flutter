import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_flutter/consts/consts_app.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';

class PokemonItem extends StatelessWidget {
  final List<PokemonEntity> list;

  const PokemonItem({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                title: Text(list[index].name),
                leading: Container(
                  color: ConstsApp.getColorType(
                          type: list[index].type[0]['type']['name'])
                      ?.withOpacity(0.7),
                  child: SvgPicture.network(
                      list[index].sprites["other"]["dream_world"]
                          ["front_default"],
                      height: 100.0,
                      width: 100.0,
                      allowDrawingOutsideViewBox: true),
                )),
          );
        });
  }
}
