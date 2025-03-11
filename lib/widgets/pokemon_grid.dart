import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon_models.dart';
import 'package:flutter_pokedex/widgets/pokemon_card.dart';

class PokemonGrid extends StatefulWidget {
  final List<Pokemons> pokemon;
  const PokemonGrid({super.key, required this.pokemon});
  @override
  _PokemonGridState createState() => _PokemonGridState();
}

class _PokemonGridState extends State<PokemonGrid> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = (width > 1000)
        ? 5
        : (width > 700)
            ? 4
            : (width > 450)
                ? 3
                : 2;
    return GridView.count(
      padding: const EdgeInsets.all(7),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      semanticChildCount: 250,
      childAspectRatio: 200 / 244,
      physics: const BouncingScrollPhysics(),
      children: widget.pokemon
          .map(
            (pokemon) => PokemonCard(
              id: pokemon.id,
              name: pokemon.name,
              image: pokemon.imageUrl,
            ),
          )
          .toList(),
    );
  }
}
