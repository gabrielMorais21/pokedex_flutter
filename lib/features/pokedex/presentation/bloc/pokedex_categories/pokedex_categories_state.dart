part of 'pokedex_categories_bloc.dart';

class PokedexCategoriesState extends Equatable {
  const PokedexCategoriesState();

  @override
  List<Object?> get props => [];
}

class PokedexCategoriesLoadingState extends PokedexCategoriesState {}

class PokedexCategoriesLoadedState extends PokedexCategoriesState {
  final List<PokemonTypeEntity> list;

  const PokedexCategoriesLoadedState({required this.list});
}

class PokedexCategoriesEmptyList extends PokedexCategoriesState {}

class PokedexCategoriesErrorState extends PokedexCategoriesState {
  final String message;

  const PokedexCategoriesErrorState({required this.message});
}
