import 'package:flutter/material.dart';

class PokemonCardBackground extends StatelessWidget {
  final int id;
  const PokemonCardBackground({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Text(
      "$id",
      style: TextStyle(
        fontSize: 101,
        fontWeight: FontWeight.bold,
        color: Colors.grey[200],
      ),
    );
  }
}
