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
                  emit(const PokedexErrorState(
                    message: "Erro ao carregar pokemons",
                  ))
                }
              else
                {
                  emit(PokedexLoadingState()),
                  emit(
                    PokedexLoadedState(
                      loading: false,
                      list: listPokemon,
                      message: "Erro ao carregar mais pokemons",
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
    var pokemons = (await getAllPokemonsByType(event.name));
    return pokemons.fold(
        (failure) => emit(const PokedexErrorState(
              message: "5",
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
    var pokemons = (await getPokemonByName(event.name));
    return pokemons.fold(
        (failure) => emit(const PokedexErrorState(
              message: "Não foi possivel encontrar o pokemon pelo nome",
            )),
        (pokemons) =>
            emit(PokedexFetchListByNameState(pokemonEntity: pokemons)));
  }
}
