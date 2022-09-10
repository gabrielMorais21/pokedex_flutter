import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:pokedex_flutter/core/error/exception.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_type_model.dart';

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

class PokemonRemoteDataSourceImp implements PokemonRemoteDataSource {
  final Dio httpclient;

  PokemonRemoteDataSourceImp({required this.httpclient}) {
    httpclient.options.baseUrl = API_URL_BASE;
    // httpclient.interceptors
    //     .add(DioCacheManager(CacheConfig(baseUrl: API_URL_BASE)).interceptor);
  }

  @override
  Future<List<PokemonModel>> getAllPokemon({
    required int offset,
  }) async {
    final url = '/pokemon/?offset=$offset&limit=20';
    httpclient.interceptors
        .add(DioCacheManager(CacheConfig(baseUrl: API_URL_BASE)).interceptor);
    try {
      final response = await httpclient.get(url,
          options: buildCacheOptions(const Duration(days: 7)));
      if (response.statusCode == 200) {
        // final map = jsonDecode(response.data["results"]);

        List<PokemonModel> result = [];
        // var result3 = (map["results"] as List);
        var result3 = response.data["results"];
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
      var url = '/pokemon/$name';
      final response = await httpclient.get(url,
          options: buildCacheOptions(const Duration(days: 7)));
      if (response.statusCode == 200) {
        var pok = PokemonModel.fromJson(response.data);
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
    const url = '/type/';

    try {
      final response = await httpclient.get(url,
          options: buildCacheOptions(const Duration(days: 7)));
      if (response.statusCode == 200) {
        List<PokemonTypeModel> result = [];
        List map = response.data["results"];
        // map.forEach((element) {
        //   result.add(PokemonTypeModel.fromJson(element));
        // });

        for (var element in map) {
          result.add(PokemonTypeModel.fromJson(element));
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
  Future<List<PokemonModel>> getAllPokemonByType({required String name}) async {
    final url = '/type/$name';

    try {
      final response = await httpclient.get(url,
          options: buildCacheOptions(const Duration(days: 7)));
      if (response.statusCode == 200) {
        final map = response.data["results"];

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
