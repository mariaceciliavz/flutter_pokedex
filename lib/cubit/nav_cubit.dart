import 'package:flutter_bloc/flutter_bloc.dart';

class NavCubit extends Cubit<int> {
  NavCubit() : super(0);

  void showPokemonDetail(int id) {
    emit(id);
  }

  void popToPokedex() {
    emit(0);
  }
}
