import 'package:pokedex_flutter/features/pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon_by_type/get_all_pokemon_by_type.dart';

class GetAllPokemonByTypeImp implements GetAllPokemonByType {
  final PokemonRepository repository;

  GetAllPokemonByTypeImp({required this.repository});

  @override
  Future<Either<Failure, List<PokemonEntity>>> call(
      {required String type}) async {
    return await repository.getAllPokemonsByType(type: type);
  }
}
