import 'package:flutter/material.dart';
import 'package:pokedex_flutter/consts/consts_app.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_type_entity.dart';

class Categories extends StatelessWidget {
  final Function onTap;
  final List<PokemonTypeEntity> list;
  const Categories({Key? key, required this.list, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < list.length; i++)
            GestureDetector(
              onTap: () => onTap(list[i].name),
              child: Chip(
                padding: const EdgeInsets.all(1),
                backgroundColor: ConstsApp.getColorType(type: list[i].name)
                    ?.withOpacity(0.8),
                label: Text(list[i].name,
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
          // Chip(
          //   padding: EdgeInsets.all(0),
          //   backgroundColor: Colors.deepPurple,
          //   label: Text('BADGE', style: TextStyle(color: Colors.white)),
          // ),
        ],
      ),
    );
  }
}
