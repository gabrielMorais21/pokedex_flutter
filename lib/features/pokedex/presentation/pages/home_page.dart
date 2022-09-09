import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:pokedex_flutter/consts/consts_app.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
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
                      child: Container(
                        color: ConstsApp.getColorType(
                                type: state.list[index].type[0]['type']['name'])
                            ?.withOpacity(0.7),
                        // child: Image.network(state.list[index].sprites["other"]
                        //     ["home"]["front_default"]),
                        child: SvgPicture.network(
                            state.list[index].sprites["other"]["dream_world"]
                                ["front_default"],

                            // "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/132.svg",
                            height: 100.0,
                            width: 100.0,
                            allowDrawingOutsideViewBox: true),
                      ),
                      // child: Text(
                      //   'Item $index',
                      //   style: Theme.of(context).textTheme.headline5,
                      // ),
                    );
                  }));

            // return ListView.builder(
            //   itemCount: state.list.length,
            //   itemBuilder: (context, index) {
            // state.list[index].sprites["other"]
            //           ["dream_world"]["front_default"] ??
            // return ListTile(
            //   leading: Image.network(
            //       state.list[index].sprites["front_default"]),
            //   // leading: Image.network(
            //   //     state.list[index].sprites["back_default"]),
            //   // leading:
            //   //     Image.network(state.list[index].sprites["back_shiny"]),
            //   title: Text(
            //     state.list[index].name,
            //   ),
            // );
            //     return GridView.count(
            //         crossAxisCount: 2,
            //         children: List.generate(100, (index) {
            //           return Center(
            //             child: Image.network(
            //                 state.list[index].sprites["front_default"]),
            //             // child: Text(
            //             //   'Item $index',
            //             //   style: Theme.of(context).textTheme.headline5,
            //             // ),
            //           );
            //         }));
            //   },
            // );
            // );

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
