import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon/get_all_pokemon.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_pokemon_by_name/get_pokemon_by_name.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final GetAllPokemons getAllPokemons;
  final GetPokemonByName getPokemonByName;
  PokedexBloc({required this.getAllPokemons, required this.getPokemonByName})
      : super(EmptyState()) {
    on<LoadingSucessPokemonEvent>((event, emit) async {
      // print('teste');
      // var pokemons = await getPokemonByName("ditto");
      // print(pokemons);
      // var pk = await getAllPokemons();
      // _mapPokemonsLoadedToState();
      // var pokemons = await getAllPokemons();

      // pokemons.fold(
      //   (failure) => const ErrorState(message: "error loading pokemons"),
      //   (pokemons) => LoadedSucessState(pokemons: pokemons),
      // );
      mapPokemonsLoadedToState();
    });
  }

  @override
  PokedexState get initialState => LoadingState();

  @override
  Stream<PokedexState> mapEventToState(
    PokedexState event,
  ) async* {
    LoadingState();
    // if (event is LoadedSucessState) {
    yield* mapPokemonsLoadedToState();
    // }
  }

  Stream<PokedexState> mapPokemonsLoadedToState() async* {
    try {
      var pokemons = await getAllPokemons();

      pokemons.fold(
        (failure) => const ErrorState(message: "error loading pokemons"),
        (pokemons) => LoadedSucessState(pokemons: pokemons),
      );
    } catch (error) {
      yield ErrorState(message: "error loading pokemons" + error.toString());
    }
  }
}
