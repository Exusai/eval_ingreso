import 'package:eval_ingreso/controllers/overridePokeAPI.dart';
import 'package:eval_ingreso/models/pokemon.dart';
import 'package:eval_ingreso/views/home/pokemon_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PokemonGrid extends StatefulWidget {
  const PokemonGrid({Key? key}) : super(key: key);

  @override
  State<PokemonGrid> createState() => _PokemonGridState();
}

class _PokemonGridState extends State<PokemonGrid> {
  @override
  Widget build(BuildContext context) {
    final pokemonList = Provider.of<List<Pokemon>>(context);
    return Expanded(
      child: GridView.builder(
        shrinkWrap:true,
        itemCount: pokemonList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ), 
        itemBuilder: (BuildContext context, int index) { 
          //print(pokemonList[index].name);
          return PokemonTile(pokemon: pokemonList[index]);
        }),
    );
  }
}