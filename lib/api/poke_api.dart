import 'package:dio/dio.dart';
import 'package:flutter_pokedex/models/pokemonDetails_models.dart';

final dio = Dio();

class PokeApi {
  
  static Future<Map<String, dynamic>> getPokemonList() async {
    final response =
        await dio.get('https://pokeapi.co/api/v2/pokemon?limit=250');
    return response.data;
  }

  static Future<PokemondetailsModels> getPokemonDetails(int id) async {
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');
    return PokemondetailsModels.fromJson(response.data);
  }
}
