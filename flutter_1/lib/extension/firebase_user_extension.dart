part of 'extension.dart';

extension FirebaseUserExtension on User {
  convertToUser(
          {String name = "No Name",
          String email = "No Email",
          List<String> selectedGenres = const [],
          int balance = 0}) =>
      User1(email, name, selectedGenres, balance);

  Future<User1> fromFireStore() async => await UserService.getUser(this.email!);
}
