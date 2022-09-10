import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/repositories.dart';

class GetPokemonByName {
  final PokemonRepository repository;

  GetPokemonByName({required this.repository});

  Future<Either<Failure, PokemonEntity>> call(String name) async {
    return await repository.getPokemonByName(name: name);
  }
}
