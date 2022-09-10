import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<PokemonEntity>>> getAllPokemons(
      {required int offset});
  Future<Either<Failure, PokemonEntity>> getPokemonByName(
      {required String name});
  Future<Either<Failure, List<PokemonEntity>>> getAllPokemonsByType(
      {required String name});
  Future<Either<Failure, List<PokemonTypeEntity>>> getAllTypes();
}
