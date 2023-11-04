part of 'services.dart';

class AutServices {
  // ignore: prefer_final_fields
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static get user1 => null;

  static Future<String> signUp(
      String email, String password, String name) async {
    try {
      if (name.length > 5 && double.tryParse(name) != null && name.length > 5) {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
            email: email.toString(), password: password.toString());
        User1 user1 = result.user!.convertToUser(
            email: email, name: name.toString(), selectedGenres: []);
        await UserService.setUser(user1);
        return "";
      }
      return "Password & Username must contain at least 6 characters and one alphabet character";
    } catch (e) {
      if (e is FirebaseAuthException) {
        return e.toString().toUpperCase().split("]")[1];
      }
      return "Error Is Found";
    }
  }

  static Future<String> change(
      String email, String password, String type, whatyouwant) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      User1 user1 = result.user!.convertToUser(email: email);
      await UserService.updateUser(user1, type, whatyouwant);
      return "";
    } catch (e) {}
    return "Error Is Found";
  }

  static Future<bool> genre_exist(String email) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(email).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        if (data['selectedGenres'].length != 0) {
          return true;
        }
      }
    } catch (e) {}
    return false;
  }

  static Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      return "";
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "UNABLE TO ESTABLISH CONNECTION ON CHANNEL") {
          return "Please fill all of the fields";
        }
        if (e.code == "INVALID_LOGIN_CREDENTIALS") {
          return "Account Not Found";
        }
        return e.toString().toUpperCase().split("]")[1];
      }
      return "Error Is Found";
    }
  }

  static Future<String> changePassword(
      email, String name, String currentPassword, String newPassword) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: currentPassword.toString(),
      );

      User? user = userCredential.user;

      if (user != null &&
          newPassword.length > 5 &&
          name.length > 5 &&
          name != "" &&
          newPassword != currentPassword) {
        try {
          await user.updatePassword(newPassword);
          change(email, newPassword, "name", name);
          return "";
        } catch (e) {
          print(e);
          return e.toString().toUpperCase().split("]")[1];
        }
      } else {
        return "New Password & Username must be new and contain at least 6 characters";
      }
    } catch (e) {
      return e.toString().toUpperCase().split("]")[1];
    }
  }
}
