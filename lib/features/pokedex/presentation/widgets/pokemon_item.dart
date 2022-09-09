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
    return Column(
      children: [
        for (var i = 0; i < list.length; i++)
          ListTile(
            title: Text(list[i].name),
            leading: Container(
              color:
                  ConstsApp.getColorType(type: list[i].type[0]['type']['name'])
                      ?.withOpacity(0.7),
              child: SvgPicture.network(
                  list[i].sprites["other"]["dream_world"]["front_default"],
                  height: 100.0,
                  width: 100.0,
                  allowDrawingOutsideViewBox: true),
            ),
          ),
      ],
    );
  }
}
