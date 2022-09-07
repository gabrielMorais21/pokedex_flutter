part of 'pokedex_bloc.dart';

abstract class PokedexState extends Equatable {
  const PokedexState();
}

class EmptyState extends PokedexState {
  @override
  List<Object> get props => [];
}

class LoadingState extends PokedexState {
  @override
  List<Object> get props => [];
}

class InitialState extends PokedexState {
  const InitialState();
  @override
  List<Object> get props => [];
}

class LoadedSucessState extends PokedexState {
  final List<PokemonEntity> pokemons;

  const LoadedSucessState({required this.pokemons});
  @override
  List<Object> get props => [pokemons];
}

class ErrorState extends PokedexState {
  final String message;

  const ErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
