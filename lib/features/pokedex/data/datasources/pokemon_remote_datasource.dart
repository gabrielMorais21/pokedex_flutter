import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokedex_flutter/core/error/exception.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> getAllPokemon();
  Future<PokemonModel> getPokemonByName(String name);
}

const String API_URL_BASE = 'https://pokeapi.co/api/v2';
const Map<String, String> API_HEADERS = {
  'Content-Type': 'application/json; charset=UTF-8'
};

class PokemonRemoteDataSourceImp implements PokemonRemoteDataSource {
  final Client httpclient;

  PokemonRemoteDataSourceImp({required this.httpclient});

  @override
  Future<List<PokemonModel>> getAllPokemon() async {
    try {
      final response = await httpclient.get(
        Uri.http(
          '$API_URL_BASE/pokemon//?offset=2&limit=10',
        ),
      );
      if (response.statusCode == 200) {
        List<PokemonModel> result = (jsonDecode(response.body) as List)
            .map((i) => PokemonModel.fromJson(i))
            .toList();
        return result;
      } else {
        throw ServerException(
            "status code error" + response.statusCode.toString());
      }
    } catch (error) {
      throw ServerException('failed to load pokemons' + error.toString());
    }
  }

  @override
  Future<PokemonModel> getPokemonByName(String name) async {
    try {
      final response = await httpclient
          .get(Uri.http('$API_URL_BASE/pokemon//?offset=2&limit=10'));
      if (response.statusCode == 200) {
        return PokemonModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(
            "status code error" + response.statusCode.toString());
      }
    } catch (error) {
      throw ServerException('failed to load pokemon' + error.toString());
    }
  }
}
