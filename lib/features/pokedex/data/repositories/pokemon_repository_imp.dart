import 'package:pokedex_flutter/features/pokedex/data/datasources/remote/remote.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/models.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/core/error/error.dart';
import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/repositories.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource pokemonRemoteDataSource;

  PokemonRepositoryImpl({
    required this.pokemonRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<PokemonEntity>>> getAllPokemons(
      {required int offset}) async {
    try {
      final List<PokemonModel> pokemons =
          await pokemonRemoteDataSource.getAllPokemon(offset: offset);

      return Right(pokemons);
    } on ServerException {
      return const Left(
          ServerFailure(message: "Não foi possível consultar pokemons"));
    }
  }

  @override
  Future<Either<Failure, PokemonEntity>> getPokemonByName(
      {required String name}) async {
    try {
      return Right(await pokemonRemoteDataSource.getPokemonByName(name));
    } on ServerException {
      return const Left(ServerFailure(
          message: "Não foi possível consultar pokemon por nome"));
    }
  }

  @override
  Future<Either<Failure, List<PokemonTypeEntity>>> getAllTypes() async {
    try {
      final List<PokemonTypeModel> pokemons =
          await pokemonRemoteDataSource.getAllTypes();
      return Right(pokemons);
    } on ServerException {
      return const Left(
          ServerFailure(message: "Não foi possível consultar categorias"));
    }
  }

  @override
  Future<Either<Failure, List<PokemonEntity>>> getAllPokemonsByType(
      {required String type}) async {
    try {
      final List<PokemonModel> pokemons =
          await pokemonRemoteDataSource.getAllPokemonByType(name: type);

      return Right(pokemons);
    } on ServerException {
      return const Left(ServerFailure(
          message: "Não foi possível consultar pokemons por tipo"));
    }
  }
}
