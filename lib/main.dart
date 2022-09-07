import 'package:flutter/cupertino.dart';
import 'package:pokedex_flutter/core/database/database_helper.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/pages/myApp.dart';

import '../../../../injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  await di.init();
  runApp(MyApp());
}
