import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';

// ignore: must_be_immutable
class PokemonTypeEntityMock extends Mock implements PokemonTypeEntity {}

void main() {
  PokemonTypeEntity pokemonTypeEntity = PokemonTypeEntityMock();
  test('should return that the PokemonTypeEntity is not null', () {
    expect(pokemonTypeEntity, isNotNull);
  });
}
