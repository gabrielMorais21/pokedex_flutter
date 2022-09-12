import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';

void main() {
  const PokemonTypeEntity pokemonTypeEntity = PokemonTypeEntity(name: 'name');
  test('should return that the PokemonTypeEntity is not null', () {
    // pokemonEntity
    expect(pokemonTypeEntity, isNotNull);
  });
}
