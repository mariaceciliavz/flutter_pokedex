class PokemondetailsModels {
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

  PokemondetailsModels(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.height,
      required this.weight,
      required this.attack,
      required this.defense,
      required this.speed,
      required this.specialAttack,
      required this.specialDefense});

  factory PokemondetailsModels.fromJson(Map<String, dynamic> json) {
    return PokemondetailsModels(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl: json['sprites']['front_default'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      attack: json['stats'][1]['base_stat'] ?? 0,
      defense: json['stats'][2]['base_stat'] ?? 0,
      speed: json['stats'][5]['base_stat'] ?? 0,
      specialAttack: json['stats'][3]['base_stat'] ?? 0,
      specialDefense: json['stats'][4]['base_stat'] ?? 0,
    );
  }
}
