import 'package:bloc/bloc.dart';
part "film_state.dart";

class films_ extends Cubit<filmstate> {
  films_() : super(filmstate(uservalue: []));
  void delete() {
    emit(filmstate(uservalue: []));
  }

  void addfilms(changes) {
    emit(filmstate(uservalue: [changes]));
  }

  void addschedule(List<dynamic> changes) {
    final currentState = state.uservalue;
    emit(filmstate(uservalue: [currentState[0], changes]));
  }

  void addseat(List<dynamic> changes) {
    final currentState = state.uservalue;
    Map<String, String> seat_list = {};
    List<String> seat_alphabet = ["A", "B", "C", "D", "E", "F"];
    for (int i = 0; i < changes.length; i++) {
      for (int j = 0; j < changes[i].length; j++) {
        if (changes[i][j] == 1) {
          String seat = seat_alphabet[i] + (j + 1).toString();
          seat_list[seat] = seat;
        }
      }
    }
    emit(filmstate(uservalue: [currentState[0], currentState[1], seat_list]));
  }
}
