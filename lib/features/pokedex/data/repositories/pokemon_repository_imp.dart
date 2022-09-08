import 'package:pokedex_flutter/core/error/exception.dart';
import 'package:pokedex_flutter/core/platform/network_info.dart';
import 'package:pokedex_flutter/features/pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedex_flutter/features/pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonLocalDataSource pokemonLocalDataSource;
  final PokemonRemoteDataSource pokemonRemoteDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    required this.pokemonLocalDataSource,
    required this.pokemonRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PokemonEntity>>> getAllPokemons() async {
    if (await networkInfo.isConnected) {
      try {
        final List<PokemonModel> pokemons =
            await pokemonRemoteDataSource.getAllPokemon();
        // pokemonLocalDataSource.cachePokemons(pokemons);
        return Right(pokemons);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPokemons = await pokemonLocalDataSource.getLastPokemons();
        return Right(localPokemons);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, PokemonEntity>> getPokemonByName(
      {required String name}) async {
    return Right(await pokemonRemoteDataSource.getPokemonByName(name));
  }
}
