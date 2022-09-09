import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("bloc exemplo")),
      body: BlocBuilder<PokedexBloc, PokedexState>(
          bloc: BlocProvider.of<PokedexBloc>(context),
          builder: (context, state) {
            if (state is PokedexLoadedState)
              return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${state.list[index].name}"),
                  );
                },
              );
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
