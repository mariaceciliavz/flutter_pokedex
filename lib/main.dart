import 'package:flutter/material.dart';
import 'package:flutter_pokedex/screens/details.dart';
import 'package:flutter_pokedex/screens/home_page.dart';

void main() {
  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/details": (context) => const Details(),
      },
    );
  }
}
