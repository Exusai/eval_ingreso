import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pokemon.dart';
import 'pokeAPI.dart';

class OverridePokeAPI {
  final CollectionReference pokemonCollection = FirebaseFirestore.instance.collection('Pokemon');
  //final PokeAPI pokeAPI = PokeAPI();

  // Pokemon from snapshot
  Pokemon _pokemonFromSnapshot(DocumentSnapshot snapshot) {
    return Pokemon(
      id: int.parse(snapshot.id),
      name: snapshot.get('name') ?? '',
      height: snapshot.get('height') ?? '',
      weight: snapshot.get('weight') ?? '',
      imageUrl: snapshot.get('imageUrl') ?? '',
      types: snapshot.get('types') ?? '',
      hp: snapshot.get('hp') ?? '',
      attack: snapshot.get('attack') ?? '', 
    );
  }

  // get pokemon list
  Future<List<Pokemon>> getPokemonList() async {
    final QuerySnapshot snapshot = await pokemonCollection.get();
    return snapshot.docs.map((doc) {
      return _pokemonFromSnapshot(doc);
    }).toList();
  }

  // get single pokemon
  Future<Pokemon> getPokemon(int id) async {
    final DocumentSnapshot snapshot = await pokemonCollection.doc(id.toString()).get();
    return _pokemonFromSnapshot(snapshot);
  }

  // modify pokemon
  Future modifyPokemon(Pokemon pokemon) async {
    await pokemonCollection.doc(pokemon.id.toString()).update({
      'name': pokemon.name,
      'height': pokemon.height,
      'weight': pokemon.weight,
      'imageUrl': pokemon.imageUrl,
      'types': pokemon.types,
      'hp': pokemon.hp,
      'attack': pokemon.attack,
    });
  }
  
  // add pokemon
  Future addPokemon(Pokemon pokemon) async {
    await pokemonCollection.doc(pokemon.id.toString()).set({
      'name': pokemon.name,
      'height': pokemon.height,
      'weight': pokemon.weight,
      'imageUrl': pokemon.imageUrl,
      'types': pokemon.types,
      'hp': pokemon.hp,
      'attack': pokemon.attack,
    });
  }

  // get list of pokemons from pokeAPI and compare with list in firebase, if different, keep firebase
  Future<List<Pokemon>> getPokemons() async {
    final List<Pokemon> pokemonList = await PokeAPI.fetchPokemonList();
    final List<Pokemon> pokemonListFromFirebase = await getPokemonList();
    
    // if firebase is empty, add all pokemons from pokeAPI, else return firebase
    if (pokemonListFromFirebase.isEmpty) {
      for (Pokemon pokemon in pokemonList) {
        await addPokemon(pokemon);
      }
    } else {
      return pokemonListFromFirebase;
    }
    return pokemonListFromFirebase;
  }

  // get pokemons from firebase as stream
  Stream<List<Pokemon>> get getPokemonsAsStream {
    return pokemonCollection.snapshots().map(_pokemonFromQuerySnapshot);
  }

  // pokemon from query snapshot
  List<Pokemon> _pokemonFromQuerySnapshot(QuerySnapshot snapshot) {
    // for each 
    return snapshot.docs.map((DocumentSnapshot doc) {
      //print(doc.get('name'));
      return _pokemonFromSnapshot(doc);
    }).toList();
    
  }

}