import 'package:pokedex_flutter/features/pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon/get_all_pokemon.dart';

class GetAllPokemonImp implements GetAllPokemons {
  final PokemonRepository repository;

  GetAllPokemonImp({required this.repository});
  @override
  Future<Either<Failure, List<PokemonEntity>>> call(
      {required int offset}) async {
    return await repository.getAllPokemons(offset: offset);
  }
}
