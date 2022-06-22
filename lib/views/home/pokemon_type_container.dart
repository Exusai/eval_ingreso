import 'package:flutter/material.dart';

Color pokemonTypeBackGround(String type) { 
  // change color depending on type
  Color bg = type == 'normal' ? Colors.green :
  type == 'fire' ? Colors.red :
  type == 'water' ? Colors.blue :
  type == 'electric' ? Colors.yellow :
  type == 'grass' ? Colors.green :
  type == 'ice' ? Colors.cyan :
  type == 'fighting' ? Colors.orange :
  type == 'poison' ? Colors.purple :
  type == 'ground' ? Colors.brown :
  type == 'flying' ? Colors.indigo :
  type == 'psychic' ? Colors.pink :
  type == 'bug' ? Colors.lime :
  type == 'rock' ? Colors.brown :
  type == 'ghost' ? Colors.purple :
  type == 'dragon' ? Colors.indigo :
  type == 'dark' ? Colors.purple :
  type == 'steel' ? Colors.grey :
  type == 'fairy' ? Colors.pink :
  Colors.grey;
  
  return bg;
  }