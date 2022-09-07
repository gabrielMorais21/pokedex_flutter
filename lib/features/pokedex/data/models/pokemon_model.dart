import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  PokemonModel(
      {required int id,
      required String name,
      required int height,
      required List<Map> type,
      required List<Map> abilities,
      required List<Map> form,
      required List<Map> atacks,
      required List<Map> stats})
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
        type: json['type'],
        abilities: json['abilities'],
        form: json['form'],
        atacks: json['atacks'],
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

  @override
  List<Object> get props =>
      [id, name, height, type, abilities, form, atacks, stats];
}
