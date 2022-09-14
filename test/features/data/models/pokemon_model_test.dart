import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/models.dart';

// ignore: must_be_immutable
class PokemonModelMock extends Mock implements PokemonModel {}

void main() {
  PokemonModel pokemonModel = PokemonModelMock();
  test('should return that the PokemonModel is not null', () {
    expect(pokemonModel, isNotNull);
  });
}
