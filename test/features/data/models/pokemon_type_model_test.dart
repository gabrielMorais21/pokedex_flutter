import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_type_model.dart';

// ignore: must_be_immutable
class PokemonTypeModelMock extends Mock implements PokemonTypeModel {}

void main() {
  PokemonTypeModel pokemonTypeModel = PokemonTypeModelMock();
  test('should return that the PokemonTypeModel is not null', () {
    expect(pokemonTypeModel, isNotNull);
  });
}
