part of 'services.dart';

class historyService {
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future gethistory() async {
    User value = await AutServices().getcurrent();
    QuerySnapshot snapshot =
        await _userCollection.doc(value.email).collection("history").get();
    return snapshot.docs;
  }

  static Future gethistory_info(file_name) async {
    User value = await AutServices().getcurrent();
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _userCollection
        .doc(value.email)
        .collection("history")
        .doc(file_name)
        .get();
    return snapshot.data();
  }

  static Future updatehistory(value) async {
    User value_ = await AutServices().getcurrent();
    DocumentReference user_reference =
        await _userCollection.doc(value_.email).collection("history").doc();
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

  static Future historyrating(rate, film_code, film_real) async {
    User value = await AutServices().getcurrent();
    DocumentReference user_reference = await _userCollection
        .doc(value.email)
        .collection("history")
        .doc(film_code);
    await user_reference.update({
      "rating": rate,
    });
    await show_film(film_real).update_rating(rate);
  }
}
