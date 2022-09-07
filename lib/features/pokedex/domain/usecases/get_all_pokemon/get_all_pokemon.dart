import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/pokemon_repository.dart';

class GetAllPokemons {
  final PokemonRepository repository;

  GetAllPokemons({required this.repository});

  Future<Either<Failure, List<PokemonEntity>>> call() async {
    return await repository.getAllPokemons();
  }
}
