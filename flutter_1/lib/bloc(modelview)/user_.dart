import 'package:bloc/bloc.dart';

class user_ extends Cubit<List<String>> {
  user_() : super(["", "", "", ""]);

  void delete(changes) {
    emit(changes);
  }

  void update_username_password(changes) {
    final currentState = state.toList();
    currentState[0] = changes[0];
    currentState[1] = changes[1];
    emit(currentState);
  }

  void update_balance(int newBalance) {
    final currentState = state.toList();
    currentState[3] = newBalance.toString();
    emit(currentState);
  }

  void update_name(String newname) {
    final currentState = state.toList();
    currentState[2] = newname;
    emit(currentState);
  }

  @override
  void onChange(Change<List<String>> change) {
    super.onChange(change);
  }
}
