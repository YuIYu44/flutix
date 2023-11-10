part of 'model.dart';

class User1 extends Equatable {
  final String email;
  final String name;
  final List<String> selectedGenres;
  final int balance;

  // ignore: prefer_const_constructors_in_immutables
  User1(this.email, this.name, this.selectedGenres, this.balance);

  @override
  String toString() {
    return "[$email] - $name";
  }

  @override
  List<Object?> get props => [
        email,
        name,
        balance,
        selectedGenres,
      ];
}
