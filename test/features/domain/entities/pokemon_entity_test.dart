import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';

class PokemonEntityMock extends Fake implements PokemonEntity {}

void main() {
  PokemonEntity pokemonEntity = PokemonEntityMock();
  test('should return that the PokemonEntity is not null', () {
    // pokemonEntity
    expect(pokemonEntity, isNotNull);
  });
}
