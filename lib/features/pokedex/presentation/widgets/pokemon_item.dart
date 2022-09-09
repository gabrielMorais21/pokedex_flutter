import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pokedex_flutter/consts/consts_app.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';

class PokemonItem extends StatefulWidget {
  final Function onEndOfPage;
  final List<PokemonEntity> list;

  PokemonItem({Key? key, required this.list, required this.onEndOfPage})
      : super(key: key);

  @override
  State<PokemonItem> createState() => _PokemonItemState();
}

class _PokemonItemState extends State<PokemonItem> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    // _pagingController.appendPage(newItems, 1)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      onEndOfPage: () {
        widget.onEndOfPage();
      },
      scrollOffset: 70,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.list[index].name),
              leading: Container(
                  color: ConstsApp.getColorType(
                          type: widget.list[index].type[0]['type']['name'])
                      ?.withOpacity(0.7),
                  child: widget.list[index].sprites["front_default"] != null
                      ? Image.network(
                          widget.list[index].sprites["front_default"])
                      : Container()),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: widget.list.length),
    );
    // controller;
    // return SingleChildScrollView(
    //   controller: controller,
    //   child: SizedBox(
    //     child: Column(
    //       children: [
    //         for (var index = 0; index < list.length; index++)
    //           Row(
    //             children: [
    //               Container(
    //                   color: ConstsApp.getColorType(
    //                           type: list[index].type[0]['type']['name'])
    //                       ?.withOpacity(0.7),
    //                   child: list[index].sprites["front_default"] != null
    //                       ? Image.network(list[index].sprites["front_default"])
    //                       : Container()),
    //               Text(list[index].name),
    //             ],
    //           ),
    //         Center(
    //           child: CircularProgressIndicator(),
    //         )
    //       ],
    //     ),
    //   ),
    // );
    // return PagedListView(pagingController: pagingController, builderDelegate: builderDelegate)
  }
}
