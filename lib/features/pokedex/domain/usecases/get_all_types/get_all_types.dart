import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/core/error/error.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/repositories.dart';

class GetAllTypes {
  final PokemonRepository repository;

  GetAllTypes({required this.repository});

  Future<Either<Failure, List<PokemonTypeEntity>>> call() async {
    return await repository.getAllTypes();
  }
}
