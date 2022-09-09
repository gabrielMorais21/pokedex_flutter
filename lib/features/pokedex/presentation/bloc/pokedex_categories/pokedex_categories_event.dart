import 'package:equatable/equatable.dart';

class PokedexCategoriesEvent extends Equatable {
  const PokedexCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class PokedexCategoriesFetchList extends PokedexCategoriesEvent {}

class PokedexFetchCategoriesListWithError extends PokedexCategoriesEvent {}

class PokedexFetchCategoriesListEmptyList extends PokedexCategoriesEvent {}

class NetworkErrorEvent extends Error {}
