import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_pokemon_by_name/get_pokemon_by_name.dart';

import '../../entities/pokemon_entity_test.dart';

class GetPokemonByNameSpy extends Mock implements GetPokemonByName {
  Future<Either<Failure, PokemonEntity>> callSuccess(
      {required String name}) async {
    PokemonEntityMock pokemonEntityMock = PokemonEntityMock();
    return Right(pokemonEntityMock);
  }

  Future<Either<Failure, PokemonEntity>> callFailed(
      {required String name}) async {
    return Left(ServerFailure());
  }
}

void main() {
  final GetPokemonByNameSpy getPokemonByNameSpy = GetPokemonByNameSpy();
  test("Should return a list of pokemonEntity", () async {
    final res = await getPokemonByNameSpy.callSuccess(name: "pikachu");

    res.fold(
        (failure) => null, (types) => {expect(types, isA<PokemonEntity>())});
  });

  test('Should return a ServerFailure', () async {
    final res = await getPokemonByNameSpy.callFailed(name: "pikachu");
    res.fold((failure) => null,
        (pokemons) => {expect(pokemons, isInstanceOf<ServerFailure>())});
  });
}
