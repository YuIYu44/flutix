import 'package:bloc/bloc.dart';

class FilmState {}

class ListState extends FilmState {
  //state
  final List<String> data;
  ListState(this.data);
}

class ThechoosenState extends FilmState {
  //state
  final int counter;
  ThechoosenState(this.counter);
}

class films_ extends Cubit<FilmState> {
  films_() : super(ListState([""]));
  void delete(changes) {
    emit(changes);
  }

  void addfilms(changes) {
    if (state is ListState) {
      final List<String> currentState = (state as ListState).data;
      if (!currentState.contains(changes)) {
        currentState.add(changes);
        emit(ListState(currentState));
      }
    }
  }

  void choosen(changes) {
    emit(ThechoosenState(changes));
  }

  @override
  void onChange(Change<FilmState> change) {
    super.onChange(change);
  }
}
