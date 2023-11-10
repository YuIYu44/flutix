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

  Future getposts_weblink() async {
    DocumentSnapshot qn = await firestore
        .collection("films")
        .doc("film")
        .collection("name")
        .doc(website_link)
        .get();

    return qn.data();
  }

  Future getposts_date() async {
    qn_ = await firestore
        .collection("films")
        .doc("film")
        .collection("name")
        .doc(website_link)
        .collection("dates");
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

  // Future<void> show_schedule() async {
  //   List<dynamic> dates = await getvalue('dates');
  //   for (int i = 0; i < dates.length; i++) {
  //     dates.sort((a, b) {
  //       List<String> partsA = a.split("-");
  //       List<String> partsB = b.split("-");
  //       int dayA = int.parse(partsA[0]);
  //       int dayB = int.parse(partsB[0]);
  //       return dayA.compareTo(dayB);
  //     });
  //     // title.add([dates[i]]);
  //     final cinemas = await getvalue("/dates/" + dates[i]);
  //     for (int y = 0; y < cinemas.length; y++) {
  //       List<dynamic> time =
  //           await getvalue("/dates/" + dates[i] + "/" + cinemas[y]);
  //       List<int> time_ = time
  //           .where((element) => element != "price")
  //           .map((dynamic element) => int.parse(element))
  //           .toList();
  //       time_.sort();
  //       // title[i].add([cinemas[y]]);
  //       // title[i][y + 1].add(time_);
  //     }
  //   }
  // }

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
