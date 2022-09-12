import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/core/error/error.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';

abstract class GetAllPokemonByType {
  Future<Either<Failure, List<PokemonEntity>>> call({required String type});
}
