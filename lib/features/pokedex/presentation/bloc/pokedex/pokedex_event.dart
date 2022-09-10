part of 'pokedex_bloc.dart';

class PokedexEvent extends Equatable {
  const PokedexEvent();

  @override
  List<Object?> get props => [];
}

class PokedexFetchList extends PokedexEvent {}

class PokedexFetchListByName extends PokedexEvent {
  final String name;

  const PokedexFetchListByName({required this.name});
  @override
  List<Object?> get props => [name];
}

class PokedexFetchListByType extends PokedexEvent {
  final String name;

  const PokedexFetchListByType({required this.name});
  @override
  List<Object?> get props => [name];
}

class PokedexFetchListWithError extends PokedexEvent {}

class PokedexErrorWithAlreadyLoadedList extends PokedexEvent {}

class PokedexFetchListEmptyList extends PokedexEvent {}
