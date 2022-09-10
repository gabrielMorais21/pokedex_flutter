import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/repositories.dart';

class GetAllPokemons {
  final PokemonRepository repository;

  GetAllPokemons({required this.repository});

  Future<Either<Failure, List<PokemonEntity>>> call(
      {required int offset}) async {
    return await repository.getAllPokemons(offset: offset);
  }
}
