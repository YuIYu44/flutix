import 'package:cloud_firestore/cloud_firestore.dart';

class show_film {
  String website_link = "";
  var firestore = FirebaseFirestore.instance;
  var qn_;
  show_film(datas) {
    website_link = datas;
  }
  //show_film(userCubit.state.uservalue[0]).getposts_weblink().data['link'];
  // Future getone_docs(where, value) async {
  //   DocumentSnapshot qn =
  //       await firestore.doc("films/film/name/${website_link}${where}").get();
  //   Map<String, dynamic>? data = await qn.data() as Map<String, dynamic>?;
  //   return data![value];
  // }

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

  // Future<List<dynamic>> getvalue(childs) async {
  //   final all = await ref.child('film').child(website_link).child(childs).get();
  //   Map<dynamic, dynamic> all_ = all.value as Map<dynamic, dynamic>;
  //   return all_.keys.toList();
  // }

  // Future<List<List<int>>> show_seat(thechoosen, chooseseat) async {
  //   final ref = FirebaseDatabase.instance.ref();
  //   final seat = await ref.child('film/' + thechoosen + "/seat").get();

  //   List<List<int>> seat_list = chooseseat;
  //   if (seat.value != 0) {
  //     List<String> seat_alphabet = ["A", "B", "C", "D", "E", "F"];

  //     Map<dynamic, dynamic> seats = seat.value as Map<dynamic, dynamic>;
  //     List<dynamic> seat_ = seats.values.toList() as List<dynamic>;
  //     for (int i = 0; i < seat_.length; i++) {
  //       int index_alphabet = seat_alphabet
  //           .indexWhere((alphabet) => alphabet == seat_[i][0].toString());
  //       seat_list[index_alphabet][int.tryParse(seat_[i][1])! - 1] = 2;
  //     }
  //   } else if (seat.value == null) {
  //     return [
  //       [0]
  //     ];
  //   }
  //   return seat_list;
  // }
}
