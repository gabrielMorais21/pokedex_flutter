import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/core/error/error.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';

abstract class GetAllTypes {
  Future<Either<Failure, List<PokemonTypeEntity>>> call();
}
