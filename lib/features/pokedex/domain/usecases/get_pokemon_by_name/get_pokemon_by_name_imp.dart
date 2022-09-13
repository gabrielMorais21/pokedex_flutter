import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_pokemon_by_name/get_pokemon_by_name.dart';

class GetPokemonByNameImp implements GetPokemonByName {
  final PokemonRepository repository;

  GetPokemonByNameImp({required this.repository});
  @override
  Future<Either<Failure, PokemonEntity>> call({required String name}) async {
    return await repository.getPokemonByName(name: name);
  }
}
