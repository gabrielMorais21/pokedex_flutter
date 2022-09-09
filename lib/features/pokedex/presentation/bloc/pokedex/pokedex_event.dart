part of 'pokedex_bloc.dart';

class PokedexEvent extends Equatable {
  const PokedexEvent();

  @override
  List<Object?> get props => [];
}

class PokedexFetchList extends PokedexEvent {}

class PokedexFetchListWithError extends PokedexEvent {}

class PokedexFetchListEmptyList extends PokedexEvent {}

// types

class PokedexTypesFetchList extends PokedexEvent {}

class PokedexFetchTypesListWithError extends PokedexEvent {}

class PokedexFetchTypesListEmptyList extends PokedexEvent {}

class NetworkErrorEvent extends Error {}
