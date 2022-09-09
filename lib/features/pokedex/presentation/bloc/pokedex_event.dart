part of 'pokedex_bloc.dart';

class PokedexEvent extends Equatable {
  const PokedexEvent();

  @override
  List<Object?> get props => [];
}

class PokedexFetchList extends PokedexEvent {}

class PokedexFetchListWithError extends PokedexEvent {}

class PokedexFetchListEmptyList extends PokedexEvent {}

class NetworkErrorEvent extends Error {}
