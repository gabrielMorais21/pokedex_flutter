import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_type_entity.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_types/get_all_types.dart';

class GetAllTypesImp implements GetAllTypes {
  final PokemonRepository repository;

  GetAllTypesImp({required this.repository});
  @override
  Future<Either<Failure, List<PokemonTypeEntity>>> call() async {
    return await repository.getAllTypes();
  }
}
