import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_all_pokemon/get_all_pokemon.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/get_pokemon_by_name/get_pokemon_by_name.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class Increment extends PokedexEvent {}

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final GetAllPokemons getAllPokemons;
  final GetPokemonByName getPokemonByName;
  PokedexBloc({required this.getAllPokemons, required this.getPokemonByName})
      : super(PokedexLoadingState()) {
    print("entrou no construtor");
    on<PokedexFetchList>(_fetchList);
    // on<Increment>((PokedexEvent event, emit) async* {
    //   var state;
    //   switch (event.runtimeType) {
    //     case PokedexFetchList:
    //       state = await _fetchList();
    //       break;
    //     default:
    //   }
    //   yield state;
    //   // emit(_fetchList());
    // });
    // _fetchList();
  }

  Future<void> _fetchList(
    PokedexEvent event,
    Emitter<PokedexState> emit,
  ) async {
    // var list = await Future.delayed(
    //     Duration(seconds: 3),
    //     () => <PokemonEntity>[
    //           PokemonEntity(
    //               id: 1,
    //               name: 'name',
    //               height: 1,
    //               type: [],
    //               abilities: [],
    //               form: [],
    //               atacks: [],
    //               stats: [])
    //         ]);
    var pokemons = (await getAllPokemons());
    return pokemons.fold(
        (failure) => emit(PokedexErrorState(message: "error loading pokemons")),
        (pokemons) => emit(PokedexLoadedState(list: pokemons)));
    // pokemons.
    // return PokedexLoadedState(list: list)
    // emit(PokedexLoadedState(list: pokemons));

    // try {
    // var pokemons = await getAllPokemons();
    //   // pokemons.

    //   return pokemons.fold(
    //     (failure) => const PokedexErrorState(message: "error loading pokemons"),
    //     (pokemons) => PokedexLoadedState(list: pokemons),
    //   );
    // } catch (error) {
    //   return PokedexErrorState(
    //       message: "error loading pokemons" + error.toString());
    // }
  }

  // Stream<int> mapEventToState(event) async* {}
  // final GetAllPokemons getAllPokemons;
  // final GetPokemonByName getPokemonByName;
  // PokedexBloc({required this.getAllPokemons, required this.getPokemonByName}) : super(null);

//   Stream<PokedexState> mapPokemonsLoadedToState() async* {
//     try {
//       var pokemons = await getAllPokemons();

//       yield pokemons.fold(
//         (failure) => const ErrorState(message: "error loading pokemons"),
//         (pokemons) => LoadedSucessState(pokemons: pokemons),
//       );
//     } catch (error) {
//       yield ErrorState(message: "error loading pokemons" + error.toString());
//     }
//   }
// }
}
