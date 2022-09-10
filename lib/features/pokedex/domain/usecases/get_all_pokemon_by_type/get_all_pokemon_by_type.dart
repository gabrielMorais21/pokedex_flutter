import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/repositories.dart';

class GetAllPokemonByType {
  final PokemonRepository repository;

  GetAllPokemonByType({required this.repository});

  Future<Either<Failure, List<PokemonEntity>>> call(String name) async {
    return await repository.getAllPokemonsByType(name: name);
  }
}
