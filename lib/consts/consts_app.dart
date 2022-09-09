import 'package:flutter/material.dart';

class ConstsApp {
  // static const String whitePokeball = 'assets/images/pokeball.png';
  // static const String blackPokeball = 'assets/images/pokeball_dark.png';

  static Color? getColorType({required String type}) {
    switch (type) {
      case 'normal':
        return Colors.brown[400];
        break;
      case 'fire':
        return Colors.red;
        break;
      case 'water':
        return Colors.blue;
        break;
      case 'grass':
        return Colors.green;
        break;
      case 'electric':
        return Colors.amber;
        break;
      case 'ice':
        return Colors.cyanAccent[400];
        break;
      case 'fighting':
        return Colors.orange;
        break;
      case 'poison':
        return Colors.purple;
        break;
      case 'ground':
        return Colors.orange[300];
        break;
      case 'flying':
        return Colors.indigo[200];
        break;
      case 'psychic':
        return Colors.pink;
        break;
      case 'bug':
        return Colors.lightGreen[500];
        break;
      case 'rock':
        return Colors.grey;
        break;
      case 'ghost':
        return Colors.indigo[400];
        break;
      case 'dark':
        return Colors.brown;
        break;
      case 'dragon':
        return Colors.indigo[800];
        break;
      case 'steel':
        return Colors.blueGrey;
        break;
      case 'fairy':
        return Colors.pinkAccent[100];
        break;
      default:
        return Colors.grey;
        break;
    }
  }
}
