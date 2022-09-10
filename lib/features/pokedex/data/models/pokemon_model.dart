import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel(
      {required int id,
      required String name,
      required int height,
      required Map sprites,
      required List<dynamic> type,
      required List<dynamic> abilities,
      required List<dynamic> form,
      required List<dynamic> atacks,
      required List<dynamic> stats})
      : super(
            id: id,
            name: name,
            height: height,
            sprites: sprites,
            type: type,
            abilities: abilities,
            form: form,
            atacks: atacks,
            stats: stats);

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      sprites: json['sprites'],
      type: json['types'],
      abilities: json['abilities'],
      form: json['forms'],
      atacks: json['moves'],
      stats: json['stats'],
    );
  }

  Map<String, dynamic> toJson() {
    var m = {
      'id': id,
      'name': name,
      'height': height,
      'sprites': sprites.toString(),
      'type': type.toString(),
      'abilities': abilities.toString(),
      'form': form.toString(),
      'atacks': atacks.toString(),
      'stats': stats.toString()
    };
    // print(m);
    return m;
  }

  @override
  String toString() {
    return 'PokemonModel{id: $id, name: $name, height: $height, type: $type, abilities: $abilities, form: $form, atacks: $atacks, stats: $stats, sprites: $sprites}';
  }
}
