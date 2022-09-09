import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:pokedex_flutter/consts/consts_app.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex/pokedex_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex_categories/pokedex_categories_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex_categories/pokedex_categories_state.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/widgets/categories.dart';
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
      appBar: AppBar(title: Text("Pokedex")),
      body: Column(
        children: [
          BlocBuilder<PokedexCategoriesBloc, PokedexCategoriesState>(
              bloc: BlocProvider.of<PokedexCategoriesBloc>(context),
              builder: (context, state) {
                if (state is PokedexCategoriesLoadedState)
                  // return Text(state.list[0].name);
                  return Categories(list: state.list);

                return Center(child: CircularProgressIndicator());
              }),
          BlocBuilder<PokedexBloc, PokedexState>(
              bloc: BlocProvider.of<PokedexBloc>(context),
              builder: (context, state) {
                if (state is PokedexLoadedState)
                  // for(var i = 0; i < state.list.length, i++)
                  return Container(
                    color: ConstsApp.getColorType(
                            type: state.list[0].type[0]['type']['name'])
                        ?.withOpacity(0.7),
                    child: SvgPicture.network(
                        state.list[0].sprites["other"]["dream_world"]
                            ["front_default"],
                        height: 100.0,
                        width: 100.0,
                        allowDrawingOutsideViewBox: true),
                  );

                // return GridView.count(
                //     crossAxisCount: 2,
                //     children: List.generate(state.list.length, (index) {
                //       return Center(
                //         child: Column(
                //           children: [
                //             Container(
                //               color: ConstsApp.getColorType(
                //                       type: state.list[index].type[0]['type']
                //                           ['name'])
                //                   ?.withOpacity(0.7),
                //               child: SvgPicture.network(
                //                   state.list[index].sprites["other"]
                //                       ["dream_world"]["front_default"],
                //                   height: 100.0,
                //                   width: 100.0,
                //                   allowDrawingOutsideViewBox: true),
                //             ),
                //             FloatingActionButton(
                //               child: const Icon(Icons.remove),
                //               onPressed: () {
                //                 context
                //                     .read<PokedexBloc>()
                //                     .add(PokedexTypesFetchList());
                //               },
                //             ),
                //           ],
                //         ),
                //       );
                //     }));

                return Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }
}
