import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:pokedex_flutter/consts/consts_app.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex/pokedex_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex_categories/pokedex_categories_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex_categories/pokedex_categories_state.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/widgets/categories.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/widgets/pokemon_item.dart';
import '../../../../injection_container.dart' as di;

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
            Text("Pokedex"),
            BlocBuilder<PokedexCategoriesBloc, PokedexCategoriesState>(
                bloc: BlocProvider.of<PokedexCategoriesBloc>(context),
                builder: (context, state) {
                  if (state is PokedexCategoriesLoadedState) {
                    return Categories(
                      list: state.list,
                      onTap: (String name) {
                        print(name);
                        context
                            .read<PokedexBloc>()
                            .add(PokedexFetchListByType(name: name));
                      },
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
      body: BlocBuilder<PokedexBloc, PokedexState>(
          bloc: BlocProvider.of<PokedexBloc>(context),
          builder: (context, state) {
            if (state is PokedexLoadedState) {
              return PokemonItem(
                list: state.list,
                onEndOfPage: () {
                  context.read<PokedexBloc>().add(PokedexFetchList());
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
