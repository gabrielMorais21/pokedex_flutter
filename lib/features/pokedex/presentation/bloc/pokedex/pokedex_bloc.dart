import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon/get_all_pokemon.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon_by_type/get_all_pokemon_by_type.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_pokemon_by_name/get_pokemon_by_name.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final GetAllPokemons getAllPokemons;
  final GetPokemonByName getPokemonByName;
  final GetAllPokemonByType getAllPokemonsByType;
  int offset = 0;
  List<PokemonEntity> listPokemon = [];

  PokedexBloc(
      {required this.getAllPokemons,
      required this.getPokemonByName,
      required this.getAllPokemonsByType})
      : super(PokedexLoadingState()) {
    on<PokedexFetchList>(_fetchList);
    on<PokedexFetchListByType>(_fetchListByType);
    on<PokedexFetchListByName>(_fetchListByName);
  }

  Future<void> _fetchList(
    PokedexEvent event,
    Emitter<PokedexState> emit,
  ) async {
    emit(
      PokedexLoadedState(
        loading: true,
        list: listPokemon,
        message: '1',
      ),
    );
    var pokemons = (await getAllPokemons(offset: offset));

    return pokemons.fold(
        (failure) => {
              if (listPokemon.isEmpty)
                {
                  emit(const PokedexErrorState(
                    message: "2",
                  ))
                }
              else
                {
                  emit(
                    PokedexLoadedState(
                      loading: false,
                      list: listPokemon,
                      message: "3",
                    ),
                  )
                }
            },
        (pokemons) => {
              listPokemon.addAll(pokemons),
              emit(PokedexLoadingState()),
              emit(
                PokedexLoadedState(
                  loading: true,
                  list: listPokemon,
                  message: '4',
                ),
              ),
              offset = offset + 20
            });
  }

  Future<void> _fetchListByType(
    PokedexFetchListByType event,
    Emitter<PokedexState> emit,
  ) async {
    emit(PokedexLoadingState());
    var pokemons = (await getAllPokemonsByType(event.name));
    return pokemons.fold(
        (failure) => emit(const PokedexErrorState(
              message: "5",
            )),
        (pokemons) => emit(PokedexLoadedState(
              loading: false,
              list: pokemons,
              message: '6',
            )));
  }

  Future<void> _fetchListByName(
    PokedexFetchListByName event,
    Emitter<PokedexState> emit,
  ) async {
    emit(PokedexLoadingState());
    var pokemons = (await getPokemonByName(event.name));
    return pokemons.fold(
        (failure) => emit(const PokedexErrorState(
              message: "8",
            )),
        (pokemons) => emit(PokedexLoadedState(
            loading: false, list: [pokemons, pokemons], message: '9')));
  }
}
