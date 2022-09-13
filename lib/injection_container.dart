import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/features/pokedex/data/datasources/remote/remote.dart';
import 'package:pokedex_flutter/features/pokedex/data/repositories/pokemon_repository_imp.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/repositories.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_types/get_all_types_imp.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/usecases.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => PokedexBloc(
      getAllPokemons: GetAllPokemonImp(repository: sl()),
      getPokemonByName: GetPokemonByNameImp(repository: sl()),
      getAllPokemonsByType: GetAllPokemonByTypeImp(repository: sl())));

  sl.registerFactory(
    () => PokedexCategoriesBloc(
      getAllTypes: GetAllTypesImp(
        repository: sl(),
      ),
    ),
  );

  // use cases
  sl.registerLazySingleton(() => GetAllPokemonImp(repository: sl()));
  sl.registerLazySingleton(() => GetAllPokemonByTypeImp(repository: sl()));
  sl.registerLazySingleton(() => GetPokemonByNameImp(repository: sl()));
  sl.registerLazySingleton(() => GetAllTypesImp(repository: sl()));

  // repository

  sl.registerLazySingleton<PokemonRepository>(
      () => PokemonRepositoryImpl(pokemonRemoteDataSource: sl()));

  // Data source

  sl.registerLazySingleton<PokemonRemoteDataSource>(
      () => PokemonRemoteDataSourceImp(httpclient: sl()));

  //external

  sl.registerLazySingleton(() => Dio());
}
