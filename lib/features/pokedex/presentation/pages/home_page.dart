import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:pokedex_flutter/consts/consts_app.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex/pokedex_bloc.dart';
import '../../../../injection_container.dart' as di;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // di.sl<PokedexBloc>()..add(PokedexTypesFetchList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pokedex")),
      body: BlocBuilder<PokedexBloc, PokedexState>(
          bloc: BlocProvider.of<PokedexBloc>(context),
          builder: (context, state) {
            if (state is PokedexLoadedState)
              return GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(state.list.length, (index) {
                    return Center(
                      child: Column(
                        children: [
                          Container(
                            color: ConstsApp.getColorType(
                                    type: state.list[index].type[0]['type']
                                        ['name'])
                                ?.withOpacity(0.7),
                            child: SvgPicture.network(
                                state.list[index].sprites["other"]
                                    ["dream_world"]["front_default"],
                                height: 100.0,
                                width: 100.0,
                                allowDrawingOutsideViewBox: true),
                          ),
                          FloatingActionButton(
                            child: const Icon(Icons.remove),
                            onPressed: () {
                              context
                                  .read<PokedexBloc>()
                                  .add(PokedexTypesFetchList());
                            },
                          ),
                        ],
                      ),
                    );
                  }));

            if (state is PokedexTypeLoadedState)
              return Text(state.list[0].name);

            return Center(child: CircularProgressIndicator());
          }),
      // BlocBuilder<PokedexBloc, PokedexState>(
      //     bloc: BlocProvider.of<PokedexBloc>(context),
      //     builder: (context, state) {
      //       if (state is PokedexTypeLoadedState)
      //         return Text(state.list[0].name);

      //       return Center(child: CircularProgressIndicator());
      //     }),
    );
  }
}
