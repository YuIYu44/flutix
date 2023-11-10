import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'user_state.dart';

class user_ extends Cubit<userstate> {
  user_() : super(userstate(uservalue: [""])) {
    loadUserValue();
  }

  Future<void> loadUserValue() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? "";
    final password = prefs.getString('password') ?? "";

    List<String> uservalues = [email, password];

    emit(userstate(uservalue: uservalues));
  }

  void delete() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    emit(userstate(uservalue: ["", "", "", ""]));
  }

  void update_shared(changes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", changes[0]);
    prefs.setString("password", changes[1]);
  }

  void update_username_password(changes) async {
    update_shared(changes);
    final currentState = state.uservalue;
    currentState[0] = changes[0];
    currentState[1] = changes[1];
    emit(userstate(uservalue: currentState));
  }

  void update_balance(int newBalance) {
    final currentState = state.uservalue;
    if (currentState.length < 4) {
      currentState.add(newBalance.toString());
    } else {
      currentState[3] = newBalance.toString();
    }
    emit(userstate(uservalue: currentState));
  }

  void update_name(String newname) async {
    final currentState = state.uservalue;
    if (currentState.length < 3) {
      currentState.add(newname);
    } else {
      currentState[2] = newname;
    }
    emit(userstate(uservalue: currentState));
  }
}
