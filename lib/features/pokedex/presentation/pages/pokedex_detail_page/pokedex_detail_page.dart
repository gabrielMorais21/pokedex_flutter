import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_flutter/common/common.dart';

class PokedexDetailPage extends StatelessWidget {
  final int id;
  final String name;
  final int height;
  final String image;
  final List<dynamic> type;
  final List<dynamic> abilities;
  final List<dynamic> form;
  final List<dynamic> atacks;
  final List<dynamic> stats;

  const PokedexDetailPage(
      {Key? key,
      required this.id,
      required this.name,
      required this.height,
      required this.image,
      required this.type,
      required this.abilities,
      required this.form,
      required this.atacks,
      required this.stats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color(0XFF2c2c2c),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Stack(
                children: [
                  Positioned(
                    child: SvgPicture.asset(
                      'assets/poke-types/${type[0]['type']['name']}.svg',
                      color:
                          (ConstsApp.getColorType(type: type[0]['type']['name'])
                              ?.withOpacity(0.7)),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        height: 160,
                        child: Hero(
                          tag: id,
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://cdn.traction.one/pokedex/pokemon/${id}.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              // height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              color: Colors.transparent,
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      )),
                  // )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text("Tipo: "),
                            subtitle: Row(
                              children: [
                                for (var index = 0;
                                    index < type.length;
                                    index++)
                                  Chip(
                                    padding: const EdgeInsets.all(1),
                                    backgroundColor: Darken.darken(
                                        ConstsApp.getColorType(
                                                type: type[index]['type']
                                                    ['name'])
                                            ?.withOpacity(0.7)),
                                    label: Text(type[index]['type']['name'],
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: const Text("Ataques: "),
                            subtitle: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var index = 0;
                                      index < atacks.length;
                                      index++)
                                    Chip(
                                      padding: const EdgeInsets.all(1),
                                      backgroundColor: Darken.darken(
                                          ConstsApp.getColorType(
                                                  type: type[0]['type']['name'])
                                              ?.withOpacity(0.7)),
                                      label: Text(atacks[index]['move']['name'],
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text("Habilidades: "),
                            subtitle: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var index = 0;
                                      index < abilities.length;
                                      index++)
                                    Chip(
                                      padding: const EdgeInsets.all(1),
                                      backgroundColor: Darken.darken(
                                          ConstsApp.getColorType(
                                                  type: type[0]['type']['name'])
                                              ?.withOpacity(0.7)),
                                      label: Text(
                                          abilities[index]['ability']['name'],
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text("altura "),
                            subtitle: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [Text("${height}")],
                              ),
                            ),
                          ),
                          for (var index = 0; index < stats.length; index++)
                            ListTile(
                              title: Text("${stats[index]['stat']['name']}: "),
                              subtitle: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Chip(
                                  padding: const EdgeInsets.all(1),
                                  backgroundColor: Darken.darken(
                                      ConstsApp.getColorType(
                                              type: type[0]['type']['name'])
                                          ?.withOpacity(0.7)),
                                  label: Container(
                                    width: 60,
                                    child: Center(
                                      child: Text(
                                          "${stats[index]['base_stat']}",
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ListTile(
                            title: const Text("formas: "),
                            subtitle: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var index = 0;
                                      index < form.length;
                                      index++)
                                    Chip(
                                      padding: const EdgeInsets.all(1),
                                      backgroundColor: Colors.red,
                                      label: Text(form[index]['name'],
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
