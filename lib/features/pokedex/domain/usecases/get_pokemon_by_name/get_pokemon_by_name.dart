import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/core/error/error.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';

abstract class GetPokemonByName {
  Future<Either<Failure, PokemonEntity>> call({required String name});
}
