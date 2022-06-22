import 'package:eval_ingreso/models/pokemon.dart';
import 'package:eval_ingreso/views/home/pokemon_type_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PokemonDetail extends StatefulWidget {
  final Pokemon pokemon;
  PokemonDetail({required this.pokemon});
  
  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  
  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<Usuario>(context);
    //Carrito cart = Provider.of<Carrito>(context) ?? {Carrito(productos: [])};

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name.toUpperCase()),
        centerTitle: true,
        elevation: 0,
      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 0, vertical: 0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(10),
                // create a color gradient from black to pokemonbg color
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    pokemonTypeBackGround(widget.pokemon.types),
                    Color.fromARGB(255, 159, 159, 159),
                  ],
                ),
                //color: pokemonTypeBackGround(widget.pokemon.types),
              ),
              child: Hero(
                tag: widget.pokemon.name,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    widget.pokemon.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress){
                      return progress == null ? child :CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,);//LinearProgressIndicator();
                    },
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  pokemonStatRow("Pokemon Tipo: ", widget.pokemon.types),
                  pokemonStatRow("Ataque: ", widget.pokemon.attack),
                  pokemonStatRow("HP: ", widget.pokemon.hp),
                  pokemonStatRow("Altura: ", widget.pokemon.height),
                  pokemonStatRow("Peso: ", widget.pokemon.weight),
                  pokemonStatRow("ID: ", widget.pokemon.id.toString()),
                  
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget pokemonStatRow(String stat, String value){
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          stat,
          style: const TextStyle(
            //color: Theme.of(context).colorScheme.secondary,
            //fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            //color: Theme.of(context).colorScheme.secondary,
            //fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
} 