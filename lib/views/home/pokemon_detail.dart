import 'package:eval_ingreso/controllers/overridePokeAPI.dart';
import 'package:eval_ingreso/models/pokemon.dart';
import 'package:eval_ingreso/views/home/pokemon_type_container.dart';
import 'package:flutter/material.dart';

class PokemonDetail extends StatefulWidget {
  final Pokemon pokemon;
  PokemonDetail({required this.pokemon});
  
  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  int attackInt = 0;
  int hpInt = 0;
  int heightInt = 0;

  @override
  void initState() {
    super.initState();
    attackInt = int.parse(widget.pokemon.attack);
    hpInt = int.parse(widget.pokemon.hp);
    heightInt = int.parse(widget.pokemon.height);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name.toUpperCase()),
        centerTitle: true,
        elevation: 0,
      ),
      
      body: SingleChildScrollView(
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
                    const Color.fromARGB(255, 170, 170, 170),
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
                  pokemonStatRow("ID: ", widget.pokemon.id.toString()),
                  pokemonStatRow("Pokemon Tipo: ", widget.pokemon.types),
                  pokemonStatRow("Peso: ", "${double.parse(widget.pokemon.weight)/10} kg"),
                  const Divider(),
                  //Atack bar
                  Column(
                    children: [
                      pokemonStatRow("Ataque:", "$attackInt/360"),
                      Slider(
                        value: attackInt.toDouble(),
                        min: 0,
                        max: 360,
                        divisions: 360,
                        label: attackInt.toString(),
                        activeColor: Colors.amber,
                        onChanged: (newVal){
                          setState(() {
                            attackInt = newVal.toInt();
                          });
                        },
                        onChangeEnd: (val) {
                          // TODO: push to server
                          sendChangesToServer(attackInt, hpInt, heightInt);
                        },
                      ),
                    ],
                  ),

                  //HP bar pokemonSliderBar("HP:", hpInt, Colors.blue),
                  Column(
                    children: [
                      pokemonStatRow("HP:", "$hpInt/360"),
                      Slider(
                        value: hpInt.toDouble(),
                        min: 0,
                        max: 360,
                        divisions: 360,
                        label: hpInt.toString(),
                        activeColor: Colors.blue,
                        onChanged: (newVal){
                          setState(() {
                            hpInt = newVal.toInt();
                          });
                        },
                        onChangeEnd: (val) {
                          // TODO: push to server
                          sendChangesToServer(attackInt, hpInt, heightInt);
                        },
                      ),
                    ],
                  ),

                  //height bar pokemonSliderBar("Altura:", heightInt, Colors.greenAccent),
                  Column(
                    children: [
                      pokemonStatRow("Altura:", "$heightInt/360"),
                      Slider(
                        value: heightInt.toDouble(),
                        min: 0,
                        max: 360,
                        divisions: 360,
                        label: heightInt.toString(),
                        activeColor: Colors.greenAccent,
                        onChanged: (newVal){
                          setState(() {
                            heightInt = newVal.toInt();
                          });
                        },
                        onChangeEnd: (val) {
                          // TODO: push to server
                          sendChangesToServer(attackInt, hpInt, heightInt);
                        },
                      ),
                    ],
                  ),

                  const Text("Al mover los sliders, la información automaticamnete se enviará y se guardará en firebase. Los cambios se reflejarán en tiempo real en todos los dispositivos que esten escuchando el stream"),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
      
          ],
        ),
      ),
    );
  }

  void sendChangesToServer(int atk, int hp, int height) async {
    Pokemon modPokemon = widget.pokemon;
    modPokemon.attack = atk.toString();
    modPokemon.hp = hp.toString();
    modPokemon.height = height.toString();  
    OverridePokeAPI.modifyPokemon(modPokemon);
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