import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pokedex_flutter/common/common.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/pages/pages.dart';

class PokemonItem extends StatefulWidget {
  final PokemonEntity pokemonEntity;

  const PokemonItem({
    Key? key,
    required this.pokemonEntity,
  }) : super(key: key);

  @override
  State<PokemonItem> createState() => _PokemonItemState();
}

class _PokemonItemState extends State<PokemonItem> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => PokedexDetailPage(
                  id: widget.pokemonEntity.id,
                  name: widget.pokemonEntity.name,
                  height: widget.pokemonEntity.height,
                  sprites: widget.pokemonEntity.sprites,
                  type: widget.pokemonEntity.type,
                  abilities: widget.pokemonEntity.abilities,
                  form: widget.pokemonEntity.form,
                  atacks: widget.pokemonEntity.atacks,
                  stats: widget.pokemonEntity.stats),
            ));
      },
      child: Container(
        height: 200,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: ConstsApp.getColorType(
                  type: widget.pokemonEntity.type[0]['type']['name'])
              ?.withOpacity(0.7),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              height: 230,
              // left: 100,
              child: SvgPicture.asset(
                'assets/poke-types/${widget.pokemonEntity.type[0]['type']['name']}.svg',
                color: (ConstsApp.getColorType(
                        type: widget.pokemonEntity.type[0]['type']['name'])
                    ?.withOpacity(0.7)),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '#00' + widget.pokemonEntity.id.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          height: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          "${widget.pokemonEntity.name[0].toUpperCase()}${widget.pokemonEntity.name.substring(1)}",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // softWrap: false,
                        ),
                      ),
                      Row(
                        children: [
                          for (var index = 0;
                              index < widget.pokemonEntity.type.length;
                              index++)
                            Chip(
                              padding: const EdgeInsets.all(1),
                              backgroundColor: Darken.darken(
                                  ConstsApp.getColorType(
                                          type: widget.pokemonEntity.type[index]
                                              ['type']['name'])
                                      ?.withOpacity(0.7)),
                              label: Text(
                                  widget.pokemonEntity.type[index]['type']
                                      ['name'],
                                  style: const TextStyle(color: Colors.white)),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 160,
                      child: Hero(
                        tag: widget.pokemonEntity.id,
                        child: widget.pokemonEntity.sprites["front_default"] !=
                                null
                            ? CachedNetworkImage(
                                imageUrl:
                                    "https://cdn.traction.one/pokedex/pokemon/${widget.pokemonEntity.id}.png",
                                // imageUrl:
                                //     widget.pokemonEntity.sprites["front_default"],
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    // Icon(Icons.error),
                                    CachedNetworkImage(
                                      imageUrl: widget.pokemonEntity
                                          .sprites["front_default"],
                                      fit: BoxFit.cover,
                                    ))
                            : Image.asset('assets/pokeball.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
