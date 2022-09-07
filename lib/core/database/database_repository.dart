import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseRepository {
  Future<List<PokemonModel>> getAll();
  insert(List<PokemonModel> rows);
  update(List<PokemonModel> rows);
  Future<PokemonModel> findById(id);
}

class DatabaseRepositoryImp implements DatabaseRepository {
  static const _table = "pokemon";
  final Future<Database> database;
  DatabaseRepositoryImp({required this.database});

  @override
  Future<PokemonModel> findById(id) async {
    final Database db = await database;

    try {
      List<Map<String, dynamic>> maps = await db.query(_table,
          columns: [
            "id",
            "name",
            "height",
            "type",
            "abilities",
            "form",
            "atacks",
            "stats"
          ],
          where: 'id = ?',
          whereArgs: [id]);
      if (maps.isNotEmpty) {
        return PokemonModel.fromJson(maps.first);
      }
    } catch (error) {
      print(error);
    }
    return PokemonModel(
        id: id,
        name: 'name',
        height: 2,
        type: const [],
        abilities: const [],
        form: const [],
        atacks: const [],
        stats: const []);
  }

  @override
  Future<List<PokemonModel>> getAll() async {
    final Database db = await database;
    try {
      final pokemon = await db.query(_table);

      return List.generate(pokemon.length, (i) {
        return PokemonModel(
            id: pokemon[i]['id'] as int,
            name: pokemon[i]['name'] as String,
            height: pokemon[i]['height'] as int,
            type: pokemon[i]['type'] as List<Map<dynamic, dynamic>>,
            abilities: pokemon[i]['abilities'] as List<Map<dynamic, dynamic>>,
            form: pokemon[i]['form'] as List<Map<dynamic, dynamic>>,
            atacks: pokemon[i]['atacks'] as List<Map<dynamic, dynamic>>,
            stats: pokemon[i]['stats'] as List<Map<dynamic, dynamic>>);
      });
    } catch (error) {
      print(error);
    }
    return [];
  }

  @override
  insert(List<PokemonModel> rows) async {
    final Database db = await database;
    Batch batch = db.batch();

    try {
      rows.forEach((row) async {
        batch.insert(_table, row.toJson());
      });
      await batch.commit(noResult: true);
    } catch (error) {
      print(error);
    }
  }

  @override
  update(List<PokemonModel> rows) async {
    final Database db = await database;
    Batch batch = db.batch();

    try {
      rows.forEach((row) async {
        batch
            .update(_table, row.toJson(), where: 'id = ?', whereArgs: [row.id]);
      });
      await batch.commit(noResult: true);
    } catch (error) {
      print(error);
    }
  }
}
