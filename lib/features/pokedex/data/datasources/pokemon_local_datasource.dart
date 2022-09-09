import 'package:pokedex_flutter/core/database/database_repository.dart';
import 'package:pokedex_flutter/features/pokedex/data/models/pokemon_model.dart';

abstract class PokemonLocalDataSource {
  Future<List<PokemonModel>> getLastPokemons();
  Future<void> cachePokemons(List<PokemonModel> pokemonsToCache);
}

class PokemonLocalDataSourceImp implements PokemonLocalDataSource {
  final DatabaseRepository databaseRepository;

  PokemonLocalDataSourceImp({required this.databaseRepository});

  @override
  Future<void> cachePokemons(List<PokemonModel> pokemonsToCache) async {
    print("call cache");
    List<PokemonModel> pokemonsAdd = [];
    List<PokemonModel> pokemonsUpdate = [];
    print("pokemonsToCache");

    pokemonsToCache.forEach((element) async {
      await databaseRepository
          .findByName(name: element.name)
          .then((pokemon) => {
                if (pokemon != null)
                  {pokemonsUpdate.add(pokemon)}
                else
                  {pokemonsAdd.add(element)}
              });
    });

    await databaseRepository.update(pokemonsUpdate);
    await databaseRepository.insert(pokemonsAdd);
  }

  @override
  Future<List<PokemonModel>> getLastPokemons() async {
    var pokemons = await databaseRepository.getAll();
    return pokemons ?? [];
  }
}
