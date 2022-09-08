import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  PokemonModel(
      {required int id,
      required String name,
      required int height,
      required List<dynamic> type,
      required List<dynamic> abilities,
      required List<dynamic> form,
      required List<dynamic> atacks,
      required List<dynamic> stats})
      : super(
            id: id,
            name: name,
            height: height,
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
        type: json['types'],
        abilities: json['abilities'],
        form: json['forms'],
        atacks: json['moves'],
        stats: json['stats']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'type': type,
      'abilities': abilities,
      'form': form,
      'atacks': atacks,
      'stats': stats
    };
  }

  @override
  String toString() {
    return 'PokemonModel{id: $id, name: $name, height: $height, type: $type, abilities: $abilities, form: $form, atacks: $atacks, stats: $stats}';
  }

  // @override
  // List<Object> get props =>
  //     [id, name, height, type, abilities, form, atacks, stats];
}
