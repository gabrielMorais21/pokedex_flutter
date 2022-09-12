import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_flutter/core/error/error.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/pokemon_repository.dart';
import '../../domain/entities/pokemon_entity_test.dart';

class PokemonRepositoryImpl extends Fake implements PokemonRepository {
  Future<Either<Failure, List<PokemonEntity>>> getAllPokemonsWithSucess(
      {required int offset}) async {
    List<PokemonEntity> pokemonListMock = [PokemonEntityMock()];
    return Right(pokemonListMock);
  }

  Future<Either<Failure, List<PokemonEntity>>> getAllPokemonsWithFailed(
      {required int offset}) async {
    return Left(ServerFailure());
  }
}
