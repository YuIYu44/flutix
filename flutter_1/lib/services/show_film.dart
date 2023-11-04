import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class show_film {
  List<dynamic> title = [];
  List<dynamic> data = [];
  show_film(datas) {
    data = datas;
  }
  Future<void> titles() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot =
        await ref.child('film').child(data[0] + "\\sinopsis").get();
    if (snapshot.exists) {
      final snapshots = await ref.child('film').child(data[0]).get();

      Map<String, dynamic>? snapshotValue =
          snapshots.value as Map<String, dynamic>?;
      title = [
        snapshotValue!['link'],
        snapshotValue['name'],
        snapshotValue['category'],
        snapshotValue['sinopsis'],
        // [snapshotValue['castlist']]
      ];
    } else {
      var url = Uri.parse('https://www.themoviedb.org/movie/' + data[0]);
      var response = await http.get(url);
      BeautifulSoup bs = await BeautifulSoup(response.body);
      bs = await BeautifulSoup(response.body);
      final link = await ref.child('film/${data[0]}/link').get();
      String link_ = link.value.toString();
      final allHeaderName =
          bs.find('div.title.ott_true a') ?? bs.find('div.title.ott_false a');
      String allHeaderName_ = allHeaderName!.getText();
      final characters = bs.findAll('ol.people li.card');
      var castList = characters.map((characters) {
        return [
          characters.find('a')?.text ?? '',
          characters.find('p.character')?.text ?? ''
        ];
      }).toList();
      final sinopsis = bs.find('div', class_: 'overview')!.find('p')!.getText();
      title = [
        link_,
        allHeaderName_,
        data[1],
        sinopsis,
        // [castList]
      ];
      ref.child('film').child(data[0]).update({
        'name': allHeaderName_,
        'sinopsis': sinopsis,
        //'castList': [castList]
      });
      print("ccc ${title}");
    }
  }

  title_(index1) {
    return title[index1];
  }
}
