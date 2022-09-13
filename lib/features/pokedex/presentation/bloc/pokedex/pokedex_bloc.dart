import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/entities.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/usecases.dart';

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
    var pokemons = (await getAllPokemons(offset: offset));

    return pokemons.fold(
        (failure) => {
              if (listPokemon.isEmpty)
                {
                  emit(PokedexLoadingState()),
                  emit(PokedexErrorState(
                    message: failure.message,
                  ))
                }
              else
                {
                  emit(PokedexLoadingState()),
                  emit(
                    PokedexLoadedState(
                      loading: false,
                      list: listPokemon,
                      message: failure.message,
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
                  message: '',
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
    var pokemons = (await getAllPokemonsByType(type: event.name));
    return pokemons.fold(
        (failure) => emit(PokedexErrorState(
              message: failure.message,
            )),
        (pokemons) => emit(PokedexLoadedByTypeState(
              list: pokemons,
            )));
  }

  Future<void> _fetchListByName(
    PokedexFetchListByName event,
    Emitter<PokedexState> emit,
  ) async {
    emit(PokedexLoadingState());
    var pokemons = (await getPokemonByName(name: event.name));
    return pokemons.fold(
        (failure) => emit(PokedexErrorState(
              message: failure.message,
            )),
        (pokemons) =>
            emit(PokedexFetchListByNameState(pokemonEntity: pokemons)));
  }
}
