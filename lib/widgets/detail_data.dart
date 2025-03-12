import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/cubit/pokemonDetails_cubit.dart';
import 'package:flutter_pokedex/cubit/pokemonDetails_states.dart';
import 'package:flutter_pokedex/models/pokemon_models.dart';

class DetailData extends StatefulWidget {
  final int id;
  const DetailData({super.key, required this.id});

  @override
  State<DetailData> createState() => _DetailDataState();
}

class _DetailDataState extends State<DetailData> {
  List<Pokemons> pokemon = List.empty();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailsCubit, PokemonDetailsState>(
      builder: (context, state) {
        if (state is PokemonDetailsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PokemonDetailsLoaded) {
          return Container(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: 500,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 2,
                  color: Colors.grey,
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(71),
                topRight: Radius.circular(71),
              ),
            ),
            child: Column(
              children: [
                Text('Height: ${state.height}'),
                Text('Weight: ${state.weight}'),
                Text('Attack: ${state.attack}'),
                Text('Defense: ${state.defense}'),
                Text('Speed: ${state.speed}'),
                Text('Special Attack: ${state.specialAttack}'),
                Text('Special Defense: ${state.specialDefense}'),
              ],
            ),
          );
        } else if (state is PokemonDetailsError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
