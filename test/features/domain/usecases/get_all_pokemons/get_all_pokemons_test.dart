import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon/get_all_pokemon.dart';

import '../../entities/pokemon_entity_test.dart';

class MockSucessGetAllPokemons extends Fake implements GetAllPokemons {
  // Final PokemonRepository
  @override
  Future<Either<Failure, List<PokemonEntity>>> call(
      {required int offset}) async {
    List<PokemonEntity> pokemonListMock = [PokemonEntityMock()];
    return Right(pokemonListMock);
  }
}

class MockFailedGetAllPokemons extends Fake implements GetAllPokemons {
  @override
  Future<Either<Failure, List<PokemonEntity>>> call(
      {required int offset}) async {
    // List<PokemonEntity> pokemonListMock = [PokemonEntityMock()];
    return Left(ServerFailure());
  }
}

void main() {
  test('Should return a list of pokemonEntity', () async {
    GetAllPokemons getAllPokemons = MockSucessGetAllPokemons();
    // var pokemon;
    var result = await (getAllPokemons(offset: 1));
    result.fold((failure) => null,
        (pokemons) => {expect(pokemons, isInstanceOf<List<PokemonEntity>>())});
  });

  test('Should  return a ServerFailure', () async {
    GetAllPokemons getAllPokemons = MockFailedGetAllPokemons();
    // var pokemon;
    var result = await (getAllPokemons(offset: 1));
    result.fold((failure) => null,
        (pokemons) => {expect(pokemons, isInstanceOf<ServerFailure>())});
  });
}
