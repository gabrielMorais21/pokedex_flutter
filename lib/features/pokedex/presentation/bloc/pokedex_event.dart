part of 'pokedex_bloc.dart';

abstract class PokedexEvent extends Equatable {
  const PokedexEvent();
}

class LoadingSucessPokemonEvent extends PokedexEvent {
  @override
  List<Object> get props => [];
}

class GetPokemonEvent extends PokedexEvent {
  final String name;

  const GetPokemonEvent({required this.name});

  @override
  List<Object> get props => [];
}

class NetworkErrorEvent extends Error {}
