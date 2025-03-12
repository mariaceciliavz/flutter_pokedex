class Pokemons {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final bool isFavorite;

  Pokemons({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    this.isFavorite = false,
  });

  factory Pokemons.fromJson(Map<String, dynamic> json) {
    return Pokemons(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Pokemons copyWith({
    int? id,
    String? name,
    String? imageUrl,
    int? height,
    int? weight,
    bool? isFavorite,
  }) {
    return Pokemons(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
