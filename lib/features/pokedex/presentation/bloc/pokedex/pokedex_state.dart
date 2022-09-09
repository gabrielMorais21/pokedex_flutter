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
  final List<PokemonEntity> list;

  const PokedexLoadedState({required this.list});
}

class PokedexEmptyList extends PokedexState {}

class PokedexTypeLoadedState extends PokedexState {
  final List<PokemonTypeEntity> list;

  const PokedexTypeLoadedState({required this.list});
}

class PokedexTypeEmptyList extends PokedexState {}
