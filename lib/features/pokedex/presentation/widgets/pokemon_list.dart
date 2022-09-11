import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/widgets/widgets.dart';

class PokemonList extends StatelessWidget {
  final Function onEndOfPage;
  final String message;
  final bool loading;
  final List<PokemonEntity> list;
  ScrollController controller = ScrollController();

  PokemonList(
      {Key? key,
      required this.onEndOfPage,
      required this.message,
      required this.loading,
      required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LazyLoadScrollView(
          onEndOfPage: () async {
            await onEndOfPage();
          },
          child: ListView.separated(
              controller: controller,
              itemBuilder: (context, index) {
                if (index + 1 == list.length) {
                  return loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Center(
                          child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ));
                }
                return PokemonItem(
                  pokemonEntity: list[index],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: list.length),
        ),
      ],
    );
  }
}
