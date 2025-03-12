import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/cubit/pokemon_cubit.dart';
import 'package:flutter_pokedex/cubit/pokemon_states.dart';
import 'package:flutter_pokedex/models/pokemon_models.dart';
import 'package:flutter_pokedex/widgets/pokemon_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<Pokemons> pokemon = List.empty();
  List<Pokemons> filteredPokemon = List.empty();
  String searchText = '';
  Set<int> favoritePokemonIds = {};
  bool showOnlyFavorites = false;
  final PokemonCubit pokemonCubit = PokemonCubit();

  @override
  void initState() {
    super.initState();
    loadPage();
    // getPokemonFromPokeApi();
    // loadFavoritePokemonIds();
  }

  Future<void> loadPage() async {
    await pokemonCubit.getPokemonFromPokeApi();
    pokemonCubit.loadFavoritePokemonIds();
  }

  // void getPokemonFromPokeApi() async {
  //   PokeApi.getPokemonList().then((response) {
  //     List<Map<String, dynamic>> data = List.from(response['results']);
  //     setState(() {
  //       pokemon = data.asMap().entries.map<Pokemons>((element) {
  //         element.value['id'] = element.key + 1;
  //         element.value['imageUrl'] =
  //             "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element.key + 1}.png";
  //         return Pokemons.fromJson(element.value);
  //       }).toList();
  //       filteredPokemon = pokemon;
  //     });
  //   });
  // }

  // void searchPokemon(String query) {
  //   setState(() {
  //     searchText = query.toLowerCase();
  //     applyFilters();
  //   });
  // }

  // void loadFavoritePokemonIds() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final favoriteIdsString = prefs.getString('favoritePokemonIds');
  //   if (favoriteIdsString != null) {
  //     final favoriteIdsList =
  //         favoriteIdsString.split(',').map(int.parse).toSet();
  //     setState(() {
  //       favoritePokemonIds = favoriteIdsList;
  //     });
  //   }
  // }

  // void saveFavoritePokemonIds() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final favoriteIdsString = favoritePokemonIds.join(',');
  //   await prefs.setString('favoritePokemonIds', favoriteIdsString);
  // }

  // void toggleFavorite(int pokemonId) {
  //   setState(() {
  //     if (favoritePokemonIds.contains(pokemonId)) {
  //       favoritePokemonIds.remove(pokemonId);
  //     } else {
  //       favoritePokemonIds.add(pokemonId);
  //     }
  //     saveFavoritePokemonIds();
  //     applyFilters();
  //   });
  // }

  // void applyFilters() {
  //   setState(() {
  //     filteredPokemon = pokemon
  //         .where((pokemon) =>
  //             pokemon.name.toLowerCase().contains(searchText) &&
  //             (!showOnlyFavorites || favoritePokemonIds.contains(pokemon.id)))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonCubit>(
      create: (context) => pokemonCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pokedex",
              style: TextStyle(
                color: Colors.white,
              )),
          backgroundColor: Colors.red,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  showOnlyFavorites = !showOnlyFavorites;
                  pokemonCubit.applyFilters(showOnlyFavorites);
                });
              },
              icon: Icon(showOnlyFavorites
                  ? Icons.favorite
                  : Icons.favorite_border), // Toggle icon
            ),
          ],
        ),
        body: BlocBuilder<PokemonCubit, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PokemonError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is PokemonLoaded) {
              pokemon = state.pokemons;
              filteredPokemon = state.pokemonFiltered;
              searchText = state.filter;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: pokemonCubit.searchPokemon,
                      decoration: InputDecoration(
                        hintText: 'Search Pokemon',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PokemonGrid(
                      pokemon: filteredPokemon,
                      favoritePokemonIds: favoritePokemonIds,
                      onFavoriteToggle: pokemonCubit.toggleFavorite,
                    ),
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
