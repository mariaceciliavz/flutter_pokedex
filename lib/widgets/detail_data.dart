import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon_models.dart';

class DetailData extends StatefulWidget {
  final int id;
  const DetailData({super.key, required this.id});

  @override
  State<DetailData> createState() => _DetailDataState();
}

class _DetailDataState extends State<DetailData> {
  List<Pokemons> pokemon = List.empty();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        minHeight: 500,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 2,
            color: Colors.grey,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(71),
          topRight: Radius.circular(71),
        ),
      ),
      //TODO: implementar detalhes do pokemon
    );
  }
}
