import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<PokemonEntity>>> getAllPokemons();
  Future<Either<Failure, PokemonEntity>> getPokemonByName(
      {required String name});
}
