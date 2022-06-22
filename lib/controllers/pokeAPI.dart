import 'package:dio/dio.dart';
import '../models/pokemon.dart';

class PokeAPI {
  static const String baseUrl = 'https://pokeapi.co/api/v2/';
  static const String fetch100 = baseUrl + 'pokemon?limit=100';
  static const String fetchPokemon = baseUrl + 'pokemon/';

  static Future<List<Pokemon>> fetchPokemonList() async {
    final response = await Dio().get(fetch100);
    final List<dynamic> data = response.data['results'];
    final urls = data.map((e) => e['url']).toList();
    final pokemonList = await Future.wait(
      urls.map((url) async {
        final response = await Dio().get(url);
        return Pokemon.fromJson(response.data);
      }),
    );
    return pokemonList;
  }

  static Future<Pokemon> getPokemon(String name) async {
    final response = await Dio().get(fetchPokemon + name);
    return Pokemon.fromJson(response.data);
  }

  // hash all data from a pokemon
  static String hashPokemon(Pokemon pokemon) {
    return pokemon.name + pokemon.height + pokemon.weight + pokemon.imageUrl + pokemon.types + pokemon.hp + pokemon.attack;
  }

  // compare two pokemon
  static bool comparePokemon(Pokemon pokemon1, Pokemon pokemon2) {
    return hashPokemon(pokemon1) == hashPokemon(pokemon2);
  }
}

