part of 'pokedex_bloc.dart';

class PokedexEvent extends Equatable {
  const PokedexEvent();

  @override
  List<Object?> get props => [];
}

class PokedexFetchList extends PokedexEvent {}

class PokedexFetchListByType extends PokedexEvent {
  final String name;

  const PokedexFetchListByType({required this.name});
  @override
  List<Object?> get props => [name];
}

class PokedexFetchListWithError extends PokedexEvent {}

class PokedexFetchListEmptyList extends PokedexEvent {}
