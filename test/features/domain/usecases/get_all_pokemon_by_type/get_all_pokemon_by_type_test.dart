import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon_by_type/get_all_pokemon_by_type.dart';

import '../../entities/pokemon_entity_test.dart';

class GetAllPokemonByTypeSpy extends Mock implements GetAllPokemonByType {
  Future<Either<Failure, List<PokemonEntity>>> callSuccess(
      {required String name}) async {
    final List<PokemonEntity> pokemonListMock = [PokemonEntityMock()];

    return Right(pokemonListMock);
  }

  Future<Either<Failure, List<PokemonEntity>>> callFailed(
      {required int offset}) async {
    return Left(ServerFailure());
  }
}

@GenerateMocks([GetAllPokemonByTypeSpy])
Future<void> main() async {
  final GetAllPokemonByTypeSpy mockSucessGetAllPokemons =
      GetAllPokemonByTypeSpy();

  test('Should return a list of pokemonEntity', () async {
    final res = await mockSucessGetAllPokemons.callSuccess(name: 'pikachu');

    res.fold((failure) => null,
        (pokemons) => {expect(pokemons, isA<List<PokemonEntity>>())});
  });

  test('Should return a ServerFailure', () async {
    final res = await mockSucessGetAllPokemons.callFailed(offset: 1);
    res.fold((failure) => null,
        (pokemons) => {expect(pokemons, isInstanceOf<ServerFailure>())});
  });
}
