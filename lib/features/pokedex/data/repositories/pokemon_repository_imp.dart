import 'package:pokedex_flutter/core/error/exception.dart';
import 'package:pokedex_flutter/core/platform/network_info.dart';
import 'package:pokedex_flutter/features/pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_type_model.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource pokemonRemoteDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    required this.pokemonRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PokemonEntity>>> getAllPokemons(
      {required int offset}) async {
    var isisConnected = await networkInfo.isConnected();
    isisConnected = true;
    if (isisConnected) {
      try {
        final List<PokemonModel> pokemons =
            await pokemonRemoteDataSource.getAllPokemon(offset: offset);

        return Right(pokemons);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, PokemonEntity>> getPokemonByName(
      {required String name}) async {
    return Right(await pokemonRemoteDataSource.getPokemonByName(name));
  }

  @override
  Future<Either<Failure, List<PokemonTypeEntity>>> getAllTypes() async {
    var isisConnected = await networkInfo.isConnected();
    isisConnected = true;
    if (isisConnected) {
      try {
        final List<PokemonTypeModel> pokemons =
            await pokemonRemoteDataSource.getAllTypes();
        // pokemonLocalDataSource.cachePokemons(pokemons);
        return Right(pokemons);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<PokemonEntity>>> getAllPokemonsByType(
      {required String name}) async {
    var isisConnected = await networkInfo.isConnected();
    isisConnected = true;
    if (isisConnected) {
      try {
        final List<PokemonModel> pokemons =
            await pokemonRemoteDataSource.getAllPokemonByType(name: name);
        // pokemonLocalDataSource.cachePokemons(pokemons);
        return Right(pokemons);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
