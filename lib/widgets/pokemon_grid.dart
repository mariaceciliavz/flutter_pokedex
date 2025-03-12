import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon_models.dart';
import 'package:flutter_pokedex/widgets/pokemon_card.dart';

class PokemonGrid extends StatelessWidget {
  final List<Pokemons> pokemon;
  final Set<int> favoritePokemonIds;
  final Function(int) onFavoriteToggle;

  const PokemonGrid({
    super.key,
    required this.pokemon,
    required this.favoritePokemonIds,
    required this.onFavoriteToggle,
  });

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
      children: pokemon
          .map(
            (pokemon) => PokemonCard(
              id: pokemon.id,
              name: pokemon.name,
              image: pokemon.imageUrl,
              isFavorite: pokemon.isFavorite, 
              onFavoriteToggle: () {
                onFavoriteToggle(pokemon.id); 
              },
            ),
          )
          .toList(),
    );
  }
}
