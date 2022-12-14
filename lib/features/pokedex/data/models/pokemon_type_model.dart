import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';

class PokemonTypeModel extends PokemonTypeEntity {
  const PokemonTypeModel({
    required String name,
  }) : super(
          name: name,
        );

  factory PokemonTypeModel.fromJson(Map<String, dynamic> json) {
    return PokemonTypeModel(name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
