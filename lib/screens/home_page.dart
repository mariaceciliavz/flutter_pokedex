import 'package:flutter/material.dart';
import 'package:flutter_pokedex/api/poke_api.dart';
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

  @override
  void initState() {
    super.initState();
    getPokemonFromPokeApi();
  }

  void getPokemonFromPokeApi() async {
    PokeApi.getPokemonList().then((response) {
      List<Map<String, dynamic>> data = List.from(response['results']);
      setState(() {
        pokemon = data.asMap().entries.map<Pokemons>((element) {
          element.value['id'] = element.key + 1;
          element.value['imageUrl'] =
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element.key + 1}.png";
          return Pokemons.fromJson(element.value);
        }).toList();
        filteredPokemon =
            pokemon; // Initialize filteredPokemon with all pokemon
      });
    });
  }

  void searchPokemon(String query) {
    setState(() {
      searchText = query.toLowerCase();
      filteredPokemon = pokemon
          .where((pokemon) => pokemon.name.toLowerCase().contains(searchText))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
        backgroundColor: Colors.red,
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: searchPokemon,
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
            child: PokemonGrid(pokemon: filteredPokemon),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Share',
        child: const Icon(
          Icons.share_rounded,
        ),
      ),
    );
  }
}
