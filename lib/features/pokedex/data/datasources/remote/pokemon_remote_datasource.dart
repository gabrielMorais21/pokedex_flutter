import 'package:pokedex_flutter/features/pokedex/data/models/models.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> getAllPokemon({
    required int offset,
  });
  Future<List<PokemonModel>> getAllPokemonByType({required String name});
  Future<PokemonModel> getPokemonByName(String name);
  Future<List<PokemonTypeModel>> getAllTypes();
}

// ignore: constant_identifier_names
const String API_URL_BASE = 'https://pokeapi.co/api/v2';
// ignore: constant_identifier_names
const Map<String, String> API_HEADERS = {
  'Content-Type': 'application/json; charset=UTF-8'
};
