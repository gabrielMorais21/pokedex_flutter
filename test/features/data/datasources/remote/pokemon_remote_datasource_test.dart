import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_flutter/features/pokedex/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_type_model.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_model.dart';

import '../../models/pokemon_model_test.dart';
import '../../models/pokemon_type_model_test.dart';

class PokemonRemoteDataSourceMock extends Mock
    implements PokemonRemoteDataSource {
  @override
  Future<List<PokemonModel>> getAllPokemon({required int offset}) async {
    final List<PokemonModel> pokemonListMock = [PokemonModelMock()];
    return pokemonListMock;
  }

  @override
  Future<List<PokemonModel>> getAllPokemonByType({required String name}) async {
    final List<PokemonModel> pokemonListMock = [PokemonModelMock()];
    return pokemonListMock;
  }

  @override
  Future<List<PokemonTypeModel>> getAllTypes() async {
    final List<PokemonTypeModel> pokemonTypeListMock = [PokemonTypeModelMock()];
    return pokemonTypeListMock;
  }

  @override
  Future<PokemonModel> getPokemonByName(String name) async {
    final PokemonModel pokemonModelMock = PokemonModelMock();
    return pokemonModelMock;
  }
}

void main() {
  final pokemonRemoteDataSource = PokemonRemoteDataSourceMock();
  test("Should return a list of PokemonModel", () async {
    var res = await pokemonRemoteDataSource.getAllPokemon(offset: 1);
    expect(res, isA<List<PokemonModel>>());
  });

  test("Should return a list of PokemonModel", () async {
    var res = await pokemonRemoteDataSource.getAllPokemonByType(name: "poison");
    expect(res, isA<List<PokemonModel>>());
  });

  test("Should return a list of PokemonTypeModel", () async {
    var res = await pokemonRemoteDataSource.getAllTypes();
    expect(res, isA<List<PokemonTypeModel>>());
  });

  test("Should return a list of PokemonModel", () async {
    var res = await pokemonRemoteDataSource.getPokemonByName("Pikachu");
    expect(res, isA<PokemonModel>());
  });
}
