import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/common/debouncer.dart';
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
  final _debouncer = Debouncer(milliseconds: 500);
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
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  boxShadow: [
                    // BoxShadow(color: Colors.green, spreadRadius: 3),
                  ],
                ),
                // color: Colors.white,
                child: TextField(
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      _debouncer.run(() => context
                          .read<PokedexBloc>()
                          .add(PokedexFetchListByName(name: value)));
                    }
                  },
                  decoration: new InputDecoration(
                      hintText: ' Ex: Pokemon', suffixIcon: Icon(Icons.search)),
                )),
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PokemonItem(
                  list: state.list,
                  onEndOfPage: () {
                    context.read<PokedexBloc>().add(PokedexFetchList());
                  },
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
