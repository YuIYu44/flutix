part of 'services.dart';

class UserService {
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static get genre => null;

  static Future<void> setUser(User1 user1) async {
    _userCollection.doc(user1.email).set({
      'email': user1.email,
      'name': user1.name,
      'balance': user1.balance,
      'selectedGenres': user1.selectedGenres,
    });
  }

  static Future<void> updateUser(User1 user1, String category, value) async {
    _userCollection.doc(user1.email).update({category: value});
  }

  static Future<User1> getUser(String email) async {
    DocumentSnapshot snapshot = await _userCollection.doc(email).get();
    return User1(snapshot['email'], snapshot['name'], snapshot['balance'],
        snapshot['selectedGenres']);
  }

  static Future<List<String>> getvalue(String email) async {
    DocumentSnapshot snapshot = await _userCollection.doc(email).get();
    List<String> value = [
      snapshot.get('name'),
      snapshot.get('balance').toString()
    ];
    return value;
  }
}
