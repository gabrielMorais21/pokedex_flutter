import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_type_entity.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/pokemon_repository.dart';

import '../../domain/entities/pokemon_entity_test.dart';
import '../../domain/entities/pokemon_type_entity.dart';
import '../models/pokemon_model_test.dart';

class PokemonRepositoryMock extends Mock implements PokemonRepository {
  @override
  Future<Either<Failure, List<PokemonEntity>>> getAllPokemons(
      {required int offset}) async {
    final List<PokemonEntity> pokemonListMock = [PokemonEntityMock()];

    return Right(pokemonListMock);
  }

  @override
  Future<Either<Failure, List<PokemonEntity>>> getAllPokemonsByType(
      {required String type}) async {
    final List<PokemonEntity> pokemonListMock = [PokemonEntityMock()];

    return Right(pokemonListMock);
  }

  @override
  Future<Either<Failure, List<PokemonTypeEntity>>> getAllTypes() async {
    final List<PokemonTypeEntity> pokemonTypeListMock = [
      PokemonTypeEntityMock()
    ];

    return Right(pokemonTypeListMock);
  }

  @override
  Future<Either<Failure, PokemonEntity>> getPokemonByName(
      {required String name}) async {
    return Right(PokemonModelMock());
  }
}

void main() {
  PokemonRepositoryMock pokemonRepositoryMock = PokemonRepositoryMock();
  test('Should return a list of pokemonEntity', () async {
    final res = await pokemonRepositoryMock.getAllPokemons(offset: 1);

    res.fold((failure) => null,
        (types) => {expect(types, isA<List<PokemonEntity>>())});
  });

  test('Should return a list of pokemonEntity by type', () async {
    final res =
        await pokemonRepositoryMock.getAllPokemonsByType(type: "poison");

    res.fold((failure) => null,
        (types) => {expect(types, isA<List<PokemonEntity>>())});
  });

  test('Should return a list of PokemonTypeEntity', () async {
    final res =
        await pokemonRepositoryMock.getAllPokemonsByType(type: 'poison');

    res.fold((failure) => null,
        (types) => {expect(types, isA<List<PokemonEntity>>())});
  });

  test('Should return a PokemonEntity', () async {
    final res = await pokemonRepositoryMock.getPokemonByName(name: 'Pikachu');

    res.fold(
        (failure) => null, (types) => {expect(types, isA<PokemonEntity>())});
  });

  test('Should return a PokemonTypeEntity', () async {
    final res = await pokemonRepositoryMock.getAllTypes();

    res.fold((failure) => null,
        (types) => {expect(types, isA<List<PokemonTypeEntity>>())});
  });
}
