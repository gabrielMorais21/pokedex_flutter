import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex/pokedex_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex_categories/pokedex_categories_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex_categories/pokedex_categories_state.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/widgets/categories.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/widgets/pokemon_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Column(
          children: [
            const Text("Pokedex"),
            BlocBuilder<PokedexCategoriesBloc, PokedexCategoriesState>(
                bloc: BlocProvider.of<PokedexCategoriesBloc>(context),
                builder: (context, state) {
                  if (state is PokedexCategoriesLoadedState) {
                    return Categories(
                      list: state.list,
                      onTap: (String name) {
                        context
                            .read<PokedexBloc>()
                            .add(PokedexFetchListByType(name: name));
                      },
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
      body: BlocBuilder<PokedexBloc, PokedexState>(
          bloc: BlocProvider.of<PokedexBloc>(context),
          builder: (context, state) {
            if (state is PokedexLoadedState) {
              return Stack(
                children: [
                  PokemonItem(
                    list: state.list,
                    onEndOfPage: () {
                      context.read<PokedexBloc>().add(PokedexFetchList());
                    },
                  ),
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
