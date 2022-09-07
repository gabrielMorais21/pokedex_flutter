import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
// torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // tem somente uma referência ao banco de dados
  static Database? _database;

  // instancia o db na primeira vez que for acessado
  Future<Database> get database async => _database ??= await _initDatabase();

  // abre o banco de dados e o cria se ele não existir
  static _initDatabase() async {
    try {
      String path = join(
          await getDatabasesPath(), DatabaseHelperEnum.getValue(DATABASE.name));
      //await deleteDatabase(path);
      return await openDatabase(path,
          version: DatabaseHelperEnum.getValue(DATABASE.version),
          onCreate: _onCreate,
          onConfigure: _onConfigure);
    } catch (error) {
      print(error);
    }
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
    print('Foreign keys turned on');
  }

  // Código SQL para criar o banco de dados e a tabela
  static Future _onCreate(Database db, int version) async {
    var sql = [
      '''DROP TABLE IF EXISTS pokemon;''',
      '''create table if not exists pokemon (
            id integer,
            title text,
            userId integer
            );'''
    ];

    for (var i = 0; i < sql.length; i++) {
      print("execute sql : " + sql[i]);
      await db.execute(sql[i]).catchError((onError) => print(onError));
    }
  }
}

enum DATABASE { name, version }

class DatabaseHelperEnum {
  static dynamic getValue(DATABASE databaseName) {
    switch (databaseName) {
      case DATABASE.name:
        return "todo_tdd.db";
      case DATABASE.version:
        return 1;
      default:
        return "";
    }
  }
}
