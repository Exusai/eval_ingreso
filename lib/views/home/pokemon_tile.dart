import 'package:eval_ingreso/models/pokemon.dart';
import 'package:eval_ingreso/views/home/pokemon_detail.dart';
import 'package:eval_ingreso/views/home/pokemon_type_container.dart';
import 'package:flutter/material.dart';

class PokemonTile extends StatelessWidget {
  final Pokemon pokemon;
  PokemonTile({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetail(pokemon: pokemon),
          ),
        );
      },
      child: Container(
        //height: 1000,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Stack(
          children: [
            // make widget semi-transparent
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: pokemonTypeBackGround(pokemon.types),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: Colors.black38,
                    ),
                    child: Text(pokemon.name, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center)
                  ),
                )
              ],
            ),
            Hero(
              tag: pokemon.name,
              child: Image.network(
                pokemon.imageUrl,
                fit: BoxFit.fill,
                alignment: Alignment.center,
                height: 250,
                width: 250,
                loadingBuilder: (context, child, progress){
                  return progress == null ? child : SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  );//LinearProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}