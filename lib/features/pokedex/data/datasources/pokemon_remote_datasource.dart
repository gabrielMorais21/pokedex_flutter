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
    final uri =
        Uri.parse('https://pokeapi.co/api/v2/pokemon/?offset=2&limit=10');

    try {
      final response = await httpclient.get(uri, headers: API_HEADERS);
      if (response.statusCode == 200) {
        final map = jsonDecode(response.body);

        // List<PokemonModel> result = (map["results"] as List)
        //     .map((i) => PokemonModel.fromJson(i))
        //     .toList();
        List<PokemonModel> result = [];
        var result3 = (map["results"] as List);
        for (var i = 0; i < result3.length; i++) {
          var test = await getPokemonByName(result3[i]["name"]);
          result.add(test);
        }

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
      final response = await httpclient.get(
          Uri.parse(
            '$API_URL_BASE/pokemon/$name',
          ),
          headers: API_HEADERS);
      if (response.statusCode == 200) {
        var pok = PokemonModel.fromJson(jsonDecode(response.body));
        return pok;
      } else {
        throw ServerException(
            "status code error" + response.statusCode.toString());
      }
    } catch (error) {
      throw ServerException('failed to load pokemon' + error.toString());
    }
  }
}
