part of 'services.dart';

class historyService {
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future gethistory(String email) async {
    QuerySnapshot snapshot =
        await _userCollection.doc(email).collection("history").get();
    return snapshot.docs;
  }

  static Future gethistory_info(String email, file_name) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _userCollection
        .doc(email)
        .collection("history")
        .doc(file_name)
        .get();
    return snapshot.data();
  }

  static Future updatehistory(name, value) async {
    DocumentReference user_reference =
        await _userCollection.doc(name).collection("history").doc();
    DocumentSnapshot snapshot = await user_reference.get();
    if (!snapshot.exists) {
      await user_reference.set({
        "link_name": value[0],
        "link_picture": value[1],
        "name": value[2],
        "category": value[3],
        "date": value[4],
        "cinema": value[5],
        "time": value[6],
        "seat": value[7]
      });
    }
  }

  static Future historyrating(name, value, film_code, film_real) async {
    DocumentReference user_reference =
        await _userCollection.doc(name).collection("history").doc(film_code);
    await user_reference.update({
      "rating": value,
    });
    await show_film(film_real).update_rating(value);
  }
}
