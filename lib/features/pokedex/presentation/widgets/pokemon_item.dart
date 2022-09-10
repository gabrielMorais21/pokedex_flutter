import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pokedex_flutter/consts/consts_app.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/pages/pokedex_detail_page/pokedex_detail_page.dart';

class PokemonItem extends StatefulWidget {
  final Function onEndOfPage;
  final List<PokemonEntity> list;

  const PokemonItem({Key? key, required this.list, required this.onEndOfPage})
      : super(key: key);

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
    return Stack(
      children: [
        LazyLoadScrollView(
          onEndOfPage: () async {
            await widget.onEndOfPage();
          },
          scrollOffset: 70,
          child: ListView.separated(
              controller: controller,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => PokedexDetailPage(
                            id: widget.list[index].id,
                            name: widget.list[index].name,
                            height: widget.list[index].height,
                            image: widget.list[index].sprites["front_default"],
                            type: widget.list[index].type,
                            abilities: widget.list[index].abilities,
                            form: widget.list[index].form,
                            atacks: widget.list[index].atacks,
                            stats: widget.list[index].stats),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(widget.list[index].name),
                    leading: Container(
                        color: ConstsApp.getColorType(
                                type: widget.list[index].type[0]['type']
                                    ['name'])
                            ?.withOpacity(0.7),
                        child:
                            widget.list[index].sprites["front_default"] != null
                                ? Image.network(
                                    widget.list[index].sprites["front_default"])
                                : Container()),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: widget.list.length),
        ),
      ],
    );
  }
}
