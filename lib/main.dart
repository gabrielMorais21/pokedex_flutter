import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/pages/pages.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/bloc.dart';
import '../../../../injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MaterialApp(
    title: 'Flutter BloC',
    theme: ThemeData.light(),
    home: MultiBlocProvider(providers: [
      BlocProvider(
        create: (BuildContext context) =>
            di.sl<PokedexBloc>()..add(PokedexFetchList()),
      ),
      BlocProvider(
        create: (BuildContext context) =>
            di.sl<PokedexCategoriesBloc>()..add(PokedexCategoriesFetchList()),
      )
    ], child: const HomePage()),
  ));
}
