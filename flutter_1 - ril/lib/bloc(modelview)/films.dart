import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
part "film_state.dart";

class films_ extends Cubit<filmstate> {
  films_() : super(filmstate(uservalue: []));
  void delete() {
    emit(filmstate(uservalue: []));
  }

  void addfilms(changes) {
    emit(filmstate(uservalue: [changes]));
  }

  void adddate(String changes) {
    final currentState = state.uservalue;
    emit(filmstate(uservalue: [currentState[0], changes]));
  }

  void addplaceandtime(List<dynamic> changes) {
    final currentState = state.uservalue;
    emit(filmstate(uservalue: [currentState[0], currentState[1], changes]));
  }

  void addseat(List<dynamic> changes) {
    final currentState = state.uservalue;
    List<String> seat_list = [];
    List<String> seat_alphabet = ["A", "B", "C", "D", "E", "F"];
    for (int i = 0; i < changes.length; i++) {
      for (int j = 0; j < changes[i].length; j++) {
        if (changes[i][j] == 1) {
          String seat = seat_alphabet[i] + (j + 1).toString();
          seat_list.add(seat);
        }
      }
    }
    emit(filmstate(uservalue: [
      currentState[0],
      currentState[1],
      currentState[2],
      seat_list
    ]));
  }

  void addprice(changes) {
    final currentState = state.uservalue;
    emit(filmstate(uservalue: [
      currentState[0],
      currentState[1],
      currentState[2],
      currentState[3],
      changes.toString(),
      "4000"
    ]));
  }

  List<dynamic> checkout_val() {
    final currentState = state.uservalue;
    return [
      currentState[2][0],
      currentState[2][1],
      DateFormat.MMMEd()
          .format(DateFormat('dd-mm-yyyy').parse(currentState[1])),
      currentState[3].length < 6
          ? currentState[3].toString().replaceAll("[", "").replaceAll("]", "")
          : currentState[3]
                  .getRange(0, 5)
                  .toString()
                  .replaceAll("(", "")
                  .replaceAll(")", "") +
              ",...",
      currentState[4] + " x " + currentState[3].length.toString(),
      currentState[5] + " x " + currentState[3].length.toString(),
      (int.tryParse(currentState[4])! * currentState[3].length) +
          (int.tryParse(currentState[5])! * currentState[3].length)
    ];
  }
}
