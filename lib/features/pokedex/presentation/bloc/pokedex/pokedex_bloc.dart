import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_type_entity.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon/get_all_pokemon.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon_by_type/get_all_pokemon_by_type.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_types/get_all_types.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_pokemon_by_name/get_pokemon_by_name.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class Increment extends PokedexEvent {}

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final GetAllPokemons getAllPokemons;
  final GetPokemonByName getPokemonByName;
  final GetAllPokemonByType getAllPokemonsByType;
  PokedexBloc(
      {required this.getAllPokemons,
      required this.getPokemonByName,
      required this.getAllPokemonsByType})
      : super(PokedexLoadingState()) {
    on<PokedexFetchList>(_fetchList);
    on<PokedexFetchListByType>(_fetchListByType);
  }

  Future<void> _fetchList(
    PokedexEvent event,
    Emitter<PokedexState> emit,
  ) async {
    var pokemons = (await getAllPokemons());

    return pokemons.fold(
        (failure) => emit(const PokedexErrorState(
              message: "error loading pokemons",
            )),
        (pokemons) => emit(PokedexLoadedState(
              list: pokemons,
            )));
  }

  Future<void> _fetchListByType(
    PokedexFetchListByType event,
    Emitter<PokedexState> emit,
  ) async {
    emit(PokedexLoadingState());
    var pokemons = (await getAllPokemonsByType(event.name));
    print(pokemons);
    return pokemons.fold(
        (failure) => emit(const PokedexErrorState(
              message: "error loading pokemons",
            )),
        (pokemons) => emit(PokedexLoadedState(
              list: pokemons,
            )));
  }
}
