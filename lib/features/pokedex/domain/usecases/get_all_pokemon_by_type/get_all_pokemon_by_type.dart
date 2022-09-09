import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/pokemon_repository.dart';

class GetAllPokemonByType {
  final PokemonRepository repository;

  GetAllPokemonByType({required this.repository});

  Future<Either<Failure, List<PokemonEntity>>> call(String name) async {
    return await repository.getAllPokemonsByType(name: name);
  }
}
