import 'package:dio/dio.dart';

final dio = Dio();

class PokeApi {
  static Future<Map<String, dynamic>> getPokemonList() async {
    final response =
        await dio.get('https://pokeapi.co/api/v2/pokemon?limit=250');
    return response.data;
  }
}