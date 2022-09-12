import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/core/error/error.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
// import 'package:pokedex_flutter/features/pokedex/domain/repositories/repositories.dart';

abstract class GetAllPokemons {
  Future<Either<Failure, List<PokemonEntity>>> call({required int offset});
}
