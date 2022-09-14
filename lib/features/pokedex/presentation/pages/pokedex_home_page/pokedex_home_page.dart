import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/common/common.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/bloc.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/widgets/pokemon_list.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/widgets/widgets.dart';

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
      backgroundColor: const Color(0XFF2c2c2c),
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 120,
        title: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: TextField(
                  onChanged: (String value) {
                    _debouncer.run(() => {
                          if (value.isNotEmpty)
                            {
                              context
                                  .read<PokedexBloc>()
                                  .add(PokedexFetchListByName(name: value))
                            }
                          else
                            {
                              context
                                  .read<PokedexBloc>()
                                  .add(PokedexFetchList())
                            }
                        });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 13, right: 15),
                    hintText: ' Ex: Pokemon',
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
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

                  if (state is PokedexCategoriesErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
      body: Stack(children: [
        BlocBuilder<PokedexBloc, PokedexState>(
            bloc: BlocProvider.of<PokedexBloc>(context),
            builder: (context, state) {
              if (state is PokedexLoadedState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PokemonList(
                    loading: state.loading,
                    message: state.message,
                    list: state.list,
                    onEndOfPage: () {
                      context.read<PokedexBloc>().add(PokedexFetchList());
                    },
                  ),
                );
              }

              if (state is PokedexErrorState) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(state.message)));
              }
              if (state is PokedexLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is PokedexLoadedByTypeState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PokemonList(
                    loading: false,
                    message: '',
                    list: state.list,
                    onEndOfPage: () {},
                  ),
                );
              }

              if (state is PokedexFetchListByNameState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PokemonItem(
                    pokemonEntity: state.pokemonEntity,
                  ),
                );
              }

              return Container();
            }),
      ]),
    );
  }
}
