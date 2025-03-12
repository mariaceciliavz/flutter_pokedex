class PokemondetailsModels {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final int attack;
  final int defense;
  final int speed;
  final int specialAttack;
  final int specialDefense;

  PokemondetailsModels(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.types,
      required this.height,
      required this.weight,
      required this.attack,
      required this.defense,
      required this.speed,
      required this.specialAttack,
      required this.specialDefense});

  factory PokemondetailsModels.fromJson(Map<String, dynamic> json) {
    return PokemondetailsModels(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      types: List<String>.from(json['types']),
      height: json['height'],
      weight: json['weight'],
      attack: json['attack'],
      defense: json['defense'],
      speed: json['speed'],
      specialAttack: json['specialAttack'],
      specialDefense: json['specialDefense'],
    );
  }
}
