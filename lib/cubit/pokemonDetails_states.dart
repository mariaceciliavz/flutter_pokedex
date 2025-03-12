import 'package:equatable/equatable.dart';

abstract class PokemonDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PokemonDetailsInitial extends PokemonDetailsState {}

class PokemonDetailsLoading extends PokemonDetailsState {}

class PokemonDetailsLoaded extends PokemonDetailsState {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final int attack;
  final int defense;
  final int speed;
  final int specialAttack;
  final int specialDefense;

  PokemonDetailsLoaded({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.specialAttack,
    required this.specialDefense,
  });

  @override
  List<Object> get props => [
        id,
        name,
        imageUrl,
        height,
        weight,
        attack,
        defense,
        speed,
        specialAttack,
        specialDefense,
        super.props
      ];
}

class PokemonDetailsError extends PokemonDetailsState {
  final String message;

  PokemonDetailsError({required this.message});
}
