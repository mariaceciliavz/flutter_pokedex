import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/api/poke_api.dart';
import 'package:flutter_pokedex/cubit/pokemon_states.dart';
import 'package:flutter_pokedex/models/pokemon_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit() : super(PokemonInitial());

  Future<void> getPokemonFromPokeApi() async {
    try {
      emit(PokemonLoading());
      final response = await PokeApi.getPokemonList();
      List<Map<String, dynamic>> data = List.from(response['results']);
      List<Pokemons> pokemon = data.asMap().entries.map<Pokemons>((element) {
        element.value['id'] = element.key + 1;
        element.value['imageUrl'] =
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element.key + 1}.png";
        return Pokemons.fromJson(element.value);
      }).toList();
      emit(PokemonLoaded(
          pokemons: pokemon, pokemonFiltered: pokemon, filter: ''));
    } catch (e) {
      emit(PokemonError(message: e.toString()));
    }
  }

  void searchPokemon(String query) {
    if (state is! PokemonLoaded) return;

    emit(PokemonLoaded(
        pokemons: (state as PokemonLoaded).pokemons,
        pokemonFiltered: (state as PokemonLoaded)
            .pokemons
            .where((pokemon) =>
                pokemon.name.toLowerCase().contains(query.toLowerCase()))
            .toList(),
        filter: query));
  }

  void loadFavoritePokemonIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIdsString = prefs.getString('favoritePokemonIds');
    if (favoriteIdsString != null) {
      final favoriteIdsList =
          favoriteIdsString.split(',').map(int.parse).toSet();
      final updatedPokemon = (state as PokemonLoaded).pokemons.map((pokemon) {
        return pokemon.copyWith(
            isFavorite: favoriteIdsList.contains(pokemon.id));
      }).toList();
      emit(PokemonLoaded(
          pokemons: (state as PokemonLoaded).pokemons,
          pokemonFiltered: updatedPokemon,
          filter: (state as PokemonLoaded).filter));
    }
  }

  void saveFavoritePokemonIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIdsString = prefs.getString('favoritePokemonIds');
    if (favoriteIdsString != null) {
      final favoriteIdsList =
          favoriteIdsString.split(',').map(int.parse).toSet();
      final favoritesPokemons = (state as PokemonLoaded)
          .pokemons
          .where((pokemon) => favoriteIdsList.contains(pokemon.id))
          .toList();
      await prefs.setString('favoritePokemonIds', favoriteIdsString);

      emit(PokemonLoaded(
          pokemons: (state as PokemonLoaded).pokemons,
          pokemonFiltered: favoritesPokemons,
          filter: (state as PokemonLoaded).filter));
    }
  }

  void toggleFavorite(int pokemonId) async {
    if (state is! PokemonLoaded) return;

    final prefs = await SharedPreferences.getInstance();
    final favoriteIdsString = prefs.getString('favoritePokemonIds');
    if (favoriteIdsString != null) {
      final favoriteIdsList =
          favoriteIdsString.split(',').map(int.parse).toSet();
      if (favoriteIdsList.contains(pokemonId)) {
        favoriteIdsList.remove(pokemonId);
      } else {
        favoriteIdsList.add(pokemonId);
      }
      final favoritesPokemons = (state as PokemonLoaded)
          .pokemons
          .where((pokemon) => favoriteIdsList.contains(pokemon.id))
          .toList();
      await prefs.setString('favoritePokemonIds', favoriteIdsList.join(','));

      emit(PokemonLoaded(
          pokemons: (state as PokemonLoaded).pokemons,
          pokemonFiltered: favoritesPokemons,
          filter: (state as PokemonLoaded).filter));
    }
  }

  void applyFilters(bool showFavorites) async {
    if (state is! PokemonLoaded) return;
    if (showFavorites) {
      final prefs = await SharedPreferences.getInstance();
      final favoriteIdsString = prefs.getString('favoritePokemonIds');
      if (favoriteIdsString != null) {
        final favoriteIdsList =
            favoriteIdsString.split(',').map(int.parse).toSet();
        final updatedPokemon = (state as PokemonLoaded).pokemons.map((pokemon) {
          return pokemon.copyWith(
              isFavorite: favoriteIdsList.contains(pokemon.id));
        }).toList();

        emit(PokemonLoaded(
            pokemons: (state as PokemonLoaded).pokemons,
            pokemonFiltered:
                updatedPokemon.where((pokemon) => pokemon.isFavorite).toList(),
            filter: (state as PokemonLoaded).filter));
      }
    } else {
      print('No favorite ids found');
      loadFavoritePokemonIds();
    }
  }
}
