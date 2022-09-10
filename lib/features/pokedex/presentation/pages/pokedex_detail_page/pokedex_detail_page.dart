import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/consts/consts_app.dart';

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
      appBar: AppBar(title: const Text("page detail")),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          // height: 600,
          child: Card(
            child: Column(
              children: [
                Container(
                    color: ConstsApp.getColorType(type: name)?.withOpacity(0.7),
                    child: Image.network(
                      image,
                      width: 200,
                    )),
                ListTile(
                  title: Text("ID: "),
                  subtitle: Text(id.toString()),
                ),
                ListTile(title: Text("Nome: "), subtitle: Text(name)),
                ListTile(
                  title: Text("Tamanho: "),
                  subtitle: Text(height.toString()),
                ),
                for (var index = 0; index < type.length; index++)
                  ListTile(
                    title: Text("tipo: "),
                    subtitle: Text(type[index]['type']['name']),
                  ),
                for (var index = 0; index < abilities.length; index++)
                  ListTile(
                    title: Text("Habilidades: "),
                    subtitle: Text(abilities[index]['ability']['name']),
                  ),
                for (var index = 0; index < form.length; index++)
                  ListTile(
                    title: Text("formas: "),
                    subtitle: Text(form[index]['name']),
                  ),
                for (var index = 0; index < atacks.length; index++)
                  ListTile(
                    title: Text("atacks: "),
                    subtitle: Text(atacks[index]['move']['name']),
                  ),
                for (var index = 0; index < stats.length; index++)
                  ListTile(
                    title: Text("stats: "),
                    subtitle: Text(stats[index]['stat']['name']),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
