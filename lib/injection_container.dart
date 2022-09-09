import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:pokedex_flutter/core/database/database_helper.dart';
import 'package:pokedex_flutter/core/database/database_repository.dart';
import 'package:pokedex_flutter/core/platform/network_info.dart';
import 'package:pokedex_flutter/features/pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedex_flutter/features/pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex_flutter/features/pokedex/data/repositories/pokemon_repository_imp.dart';
import 'package:pokedex_flutter/features/pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon/get_all_pokemon.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon_by_type/get_all_pokemon_by_type.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_types/get_all_types.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_pokemon_by_name/get_pokemon_by_name.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex/pokedex_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex_categories/pokedex_categories_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => PokedexBloc(
      getAllPokemons: GetAllPokemons(repository: sl()),
      getPokemonByName: GetPokemonByName(repository: sl()),
      getAllPokemonsByType: GetAllPokemonByType(repository: sl())));

  sl.registerFactory(
    () => PokedexCategoriesBloc(
      getAllTypes: GetAllTypes(
        repository: sl(),
      ),
    ),
  );

  // use cases
  sl.registerLazySingleton(() => GetAllPokemons(repository: sl()));
  sl.registerLazySingleton(() => GetPokemonByName(repository: sl()));
  sl.registerLazySingleton(() => GetAllTypes(repository: sl()));

  // repository

  sl.registerLazySingleton<PokemonRepository>(() => PokemonRepositoryImpl(
      networkInfo: sl(),
      pokemonLocalDataSource: sl(),
      pokemonRemoteDataSource: sl()));

  sl.registerLazySingleton<DatabaseRepository>(
      () => DatabaseRepositoryImp(database: DatabaseHelper.instance.database));

  // Data source

  sl.registerLazySingleton<PokemonRemoteDataSource>(
      () => PokemonRemoteDataSourceImp(httpclient: sl()));

  sl.registerLazySingleton<PokemonLocalDataSource>(
      () => PokemonLocalDataSourceImp(databaseRepository: sl()));

  // core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //external

  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
