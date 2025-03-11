class Pokemons {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  //final List abilities;

  Pokemons({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
  });

  factory Pokemons.fromJson(Map<String, dynamic> json) {
    return Pokemons(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      //abilities: json['abilities'],
    );
  }
}
