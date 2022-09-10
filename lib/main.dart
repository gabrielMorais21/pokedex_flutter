import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/core/database/database_helper.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex_categories/pokedex_categories_event.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/pages/pokedex_home_page/pokedex_home_page.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex/pokedex_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex_categories/pokedex_categories_bloc.dart';

import '../../../../injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  await di.init();
  runApp(MaterialApp(
    title: 'Flutter BloC',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
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
