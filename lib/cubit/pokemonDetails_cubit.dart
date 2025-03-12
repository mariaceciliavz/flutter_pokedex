import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/api/poke_api.dart';
import 'package:flutter_pokedex/cubit/pokemonDetails_states.dart';
import 'package:flutter_pokedex/models/pokemonDetails_models.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetailsState> {
  PokemonDetailsCubit() : super(PokemonDetailsInitial());

  void getPokemonDetails(int id) async {
    emit(PokemonDetailsLoading());
    try {
      final response = await PokeApi.getPokemonDetails(id);
      final pokemon =
          PokemondetailsModels.fromJson(response as Map<String, dynamic>);
      emit(PokemonDetailsLoaded(
        id: pokemon.id,
        name: pokemon.name,
        imageUrl: pokemon.imageUrl,
        types: pokemon.types,
        height: pokemon.height,
        weight: pokemon.weight,
        attack: pokemon.attack,
        defense: pokemon.defense,
        speed: pokemon.speed,
        specialAttack: pokemon.specialAttack,
        specialDefense: pokemon.specialDefense,
      ));
    } catch (e) {
      emit(PokemonDetailsError(message: e.toString()));
    }
  }
}
