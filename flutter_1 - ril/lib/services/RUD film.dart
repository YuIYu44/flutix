part of 'services.dart';

class show_film {
  String website_link = "";
  var firestore = FirebaseFirestore.instance;
  var qn_;
  show_film(datas) {
    website_link = datas;
  }
  Future getposts(kind) async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await firestore.collection("films").doc(kind).collection("name").get();
    if (kind == "film") {
      for (QueryDocumentSnapshot snapshot in qn.docs) {
        String documentId = snapshot.id;

        await notavailablefilm(documentId);
      }
    }
    qn = await firestore.collection("films").doc(kind).collection("name").get();
    return qn.docs;
  }

  Future getposts_weblink(something) async {
    DocumentSnapshot qn = await firestore
        .doc("films/film/name/${website_link}${something}")
        .get();
    return qn.data();
  }

  Future getposts_exist(something) async {
    DocumentSnapshot qn = await firestore
        .doc("films/film/name/${website_link}/${something}")
        .get();
    return qn.exists;
  }

  Future getposts_date() async {
    qn_ = await firestore.collection("films/film/name/${website_link}/dates");
    await update_date();
    QuerySnapshot qn = await qn_.get();

    return qn.docs;
  }

  Future getposts_cinema(index) async {
    List<QueryDocumentSnapshot> snapshot = await getposts_date();
    final id = snapshot[index].id;
    qn_ = qn_.doc(id).collection("cinema");
    QuerySnapshot qn2 = await qn_.get();
    return qn2.docs;
  }

  Future getposts_time(index_date, index_cinema) async {
    List<QueryDocumentSnapshot> snapshot = await getposts_cinema(index_date);
    final id = snapshot[index_cinema].id;
    qn_ = qn_.doc(id).collection("time");
    QuerySnapshot qn2 = await qn_.get();
    return qn2.docs;
  }

  Future getposts_seat(inside) async {
    DocumentSnapshot qn =
        await firestore.doc("films/film/name/${inside}").get();
    return qn.data();
  }

  Future<void> update_seat(inside, data) async {
    Map<String, dynamic>? book =
        await getposts_seat("${website_link}/${inside}")
            as Map<String, dynamic>;
    List<dynamic> booked = book["booked"];

    booked.addAll(data);
    await firestore
        .doc("films/film/name/${website_link}/${inside}")
        .update({"booked": booked});
    if (booked.length >= 44) {
      await firestore.doc("films/film/name/${website_link}/${inside}").delete();
    }
  }

  Future<void> update_date() async {
    CollectionReference qn =
        await firestore.collection("films/film/name/${website_link}/dates");
    QuerySnapshot qn2 = await qn.get();
    for (QueryDocumentSnapshot documentSnapshot in qn2.docs) {
      if (DateUtils.dateOnly(
              DateFormat('dd-MM-yyyy').parse(documentSnapshot.id))
          .isBefore(DateUtils.dateOnly(DateTime.now()))) {
        await qn.doc(documentSnapshot.id).delete();
      }
    }
  }

  Future<void> update_rating(int value) async {
    DocumentReference qn =
        await firestore.doc("films/film/name/${website_link}");
    DocumentSnapshot qn2 = await qn.get();
    if (qn2["rating"] != 0) {
      double val = ((qn2["rating"][0] * qn2["rating"][1] + value) /
          (qn2["rating"][1] + 1));
      await qn.update({
        "rating": [val, qn2["rating"][1] + 1]
      });
    } else {
      await qn.update({
        "rating": [value, 1]
      });
    }
  }

  Future<void> notavailablefilm(names) async {
    CollectionReference qn =
        await firestore.collection("films/film/name/${names}/dates");
    QuerySnapshot qn2 = await qn.get();
    DocumentReference qn_doc = await firestore.doc("films/film/name/${names}");
    if (qn2.docs.isEmpty) {
      await qn_doc.update({'available': 0});
    } else {
      await qn_doc.update({'available': 1});
    }
  }
}
