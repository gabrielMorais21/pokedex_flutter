import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';

// ignore: must_be_immutable
class PokemonEntityMock extends Mock implements PokemonEntity {}

void main() {
  PokemonEntity pokemonEntity = PokemonEntityMock();
  test('should return that the PokemonEntity is not null', () {
    // pokemonEntity
    expect(pokemonEntity, isNotNull);
  });
}
