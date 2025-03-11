import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon_screen_data.dart';
import 'package:flutter_pokedex/widgets/pokemon_card_background.dart';
import 'package:flutter_pokedex/widgets/pokemon_card_data.dart';

class PokemonCard extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  final bool isFavorite;
  final Function onFavoriteToggle;

  const PokemonCard({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  BoxDecoration getContainerDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        enableFeedback: true,
        splashColor: Colors.red[50],
        onTap: () => {
          Navigator.pushNamed(
            context,
            "/details",
            arguments: PokemonScreenData(id, name, image),
          )
        },
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: getContainerDecoration(),
          child: Stack(
            children: [
              PokemonCardBackground(id: id),
              SizedBox(
                height: 170,
                width: 170,
                child: PokemonCardData(name: name, image: image),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    onFavoriteToggle();
                  },
                  icon: isFavorite
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_border),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
