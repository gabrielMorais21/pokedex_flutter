import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_flutter/core/error/error.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_types/get_all_types.dart';

import '../../entities/pokemon_type_entity.dart';

class GetAllTypesSpy extends Mock implements GetAllTypes {
  Future<Either<Failure, List<PokemonTypeEntity>>> callSuccess() async {
    return Right([PokemonTypeEntityMock()]);
  }

  Future<Either<Failure, List<PokemonTypeEntity>>> callFailed() async {
    return const Left(ServerFailure(message: ''));
  }
}

Future<void> main() async {
  final GetAllTypesSpy getAllTypesSpy = GetAllTypesSpy();

  test('Should return a list of pokemonEntity', () async {
    final res = await getAllTypesSpy.callSuccess();

    res.fold((failure) => null,
        (types) => {expect(types, isA<List<PokemonTypeEntity>>())});
  });

  test('Should return a ServerFailure', () async {
    final res = await getAllTypesSpy.callFailed();
    res.fold((failure) => null,
        (pokemons) => {expect(pokemons, isInstanceOf<ServerFailure>())});
  });
}
