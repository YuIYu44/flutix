import 'package:cloud_firestore/cloud_firestore.dart';

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
    return qn.docs;
  }

  Future getposts_weblink(something) async {
    DocumentSnapshot qn = await firestore
        .doc("films/film/name/${website_link}${something}")
        .get();
    return qn.data();
  }

  Future getposts_date() async {
    qn_ = await firestore.collection("films/film/name/${website_link}/dates");
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
}
