import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_flutter/core/error/error.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon/get_all_pokemon.dart';
import '../../entities/pokemon_entity_test.dart';

class GetAllPokemonsSpy extends Mock implements GetAllPokemons {
  Future<Either<Failure, List<PokemonEntity>>> callSuccess(
      {required int offset}) async {
    final List<PokemonEntity> pokemonListMock = [PokemonEntityMock()];

    return Right(pokemonListMock);
  }

  Future<Either<Failure, List<PokemonEntity>>> callFailed(
      {required int offset}) async {
    return const Left(ServerFailure(message: ''));
  }
}

Future<void> main() async {
  final GetAllPokemonsSpy mockSucessGetAllPokemons = GetAllPokemonsSpy();

  test('Should return a list of pokemonEntity', () async {
    final res = await mockSucessGetAllPokemons.callSuccess(offset: 1);

    res.fold((failure) => null,
        (pokemons) => {expect(pokemons, isA<List<PokemonEntity>>())});
  });

  test('Should return a ServerFailure', () async {
    final res = await mockSucessGetAllPokemons.callFailed(offset: 1);
    res.fold((failure) => null,
        (pokemons) => {expect(pokemons, isInstanceOf<ServerFailure>())});
  });
}
