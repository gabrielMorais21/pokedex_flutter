import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokedex_flutter/core/error/exception.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_type_model.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> getAllPokemon();
  Future<List<PokemonModel>> getAllPokemonByType({required String name});
  Future<PokemonModel> getPokemonByName(String name);
  Future<List<PokemonTypeModel>> getAllTypes();
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
        Uri.parse('https://pokeapi.co/api/v2/pokemon/?offset=2&limit=20');

    try {
      final response = await httpclient.get(uri, headers: API_HEADERS);
      if (response.statusCode == 200) {
        final map = jsonDecode(response.body);

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

  @override
  Future<List<PokemonTypeModel>> getAllTypes() async {
    final uri = Uri.parse('https://pokeapi.co/api/v2/type/');

    try {
      final response = await httpclient.get(uri, headers: API_HEADERS);
      if (response.statusCode == 200) {
        final map = jsonDecode(response.body);

        List<PokemonTypeModel> result = (map["results"] as List)
            .map((i) => PokemonTypeModel.fromJson(i))
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
  Future<List<PokemonModel>> getAllPokemonByType({required String name}) async {
    final uri = Uri.parse('https://pokeapi.co/api/v2/type/$name');

    try {
      final response = await httpclient.get(uri, headers: API_HEADERS);
      if (response.statusCode == 200) {
        final map = jsonDecode(response.body);

        List<PokemonModel> result = [];
        var result3 = (map["pokemon"] as List);
        for (var i = 0; i < result3.length; i++) {
          var test = await getPokemonByName(result3[i]["pokemon"]["name"]);
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
}
