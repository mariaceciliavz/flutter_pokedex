import 'package:equatable/equatable.dart';
import 'package:flutter_pokedex/models/pokemon_models.dart';

abstract class PokemonState extends Equatable {
  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<Pokemons> pokemons;

  final List<Pokemons> pokemonFiltered;

  final String filter;

  PokemonLoaded(
      {required this.pokemons,
      required this.pokemonFiltered,
      required this.filter});
  @override
  // TODO: implement props
  List<Object> get props => [pokemons, pokemonFiltered, filter, super.props];
}

class PokemonError extends PokemonState {
  final String message;

  PokemonError({required this.message});
}
