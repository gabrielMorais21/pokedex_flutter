import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/domain/entities/pokemon_type_entity.dart';
import 'package:pokedex_flutter/features/pokedex/domain/usecases/usecases.dart';

part 'pokedex_categories_event.dart';
part 'pokedex_categories_state.dart';

class PokedexCategoriesBloc
    extends Bloc<PokedexCategoriesEvent, PokedexCategoriesState> {
  final GetAllTypes getAllTypes;
  PokedexCategoriesBloc({
    required this.getAllTypes,
  }) : super(
          PokedexCategoriesLoadingState(),
        ) {
    on<PokedexCategoriesFetchList>(
      _fetchTypeList,
    );
  }

  Future<void> _fetchTypeList(
    PokedexCategoriesEvent event,
    Emitter<PokedexCategoriesState> emit,
  ) async {
    var type = (await getAllTypes());
    return type.fold(
      (failure) => emit(
        const PokedexCategoriesErrorState(
          message: "error loading types",
        ),
      ),
      (types) => emit(
        PokedexCategoriesLoadedState(
          list: types,
        ),
      ),
    );
  }
}
