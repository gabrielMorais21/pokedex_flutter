part of 'pokedex_bloc.dart';

class PokedexState extends Equatable {
  const PokedexState();

  @override
  List<Object?> get props => [];
}

class PokedexLoadingState extends PokedexState {}

class PokemonTypeLoadingState extends PokedexState {}

class PokedexErrorState extends PokedexState {
  final String message;

  const PokedexErrorState({required this.message});
}

class PokedexLoadedState extends PokedexState {
  final String message;
  final bool loading;
  final List<PokemonEntity> list;

  const PokedexLoadedState({
    required this.list,
    required this.loading,
    required this.message,
  });
}

class PokedexLoadedByTypeState extends PokedexState {
  final List<PokemonEntity> list;

  const PokedexLoadedByTypeState({
    required this.list,
  });
}

class PokedexFetchListByNameState extends PokedexState {
  final PokemonEntity pokemonEntity;

  const PokedexFetchListByNameState({required this.pokemonEntity});
}

class PokedexErrorWithLoadedListState extends PokedexState {
  final String message;
  final List<PokemonEntity> list;

  const PokedexErrorWithLoadedListState(
      {required this.list, required this.message});
}

class PokedexEmptyList extends PokedexState {}

class PokedexTypeLoadedState extends PokedexState {
  final List<PokemonTypeEntity> list;

  const PokedexTypeLoadedState({required this.list});
}

class PokedexTypeEmptyList extends PokedexState {}
