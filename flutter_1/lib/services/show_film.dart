import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class show_film {
  List<dynamic> title = [];
  String website_link = "";
  final ref = FirebaseDatabase.instance.ref();
  show_film(datas) {
    website_link = datas;
  }
  Future<void> titles() async {
    final sinopsis =
        await ref.child('film').child(website_link + "/sinopsis").get();
    final rating =
        await ref.child('film').child(website_link + "/rating").get();
    final category =
        await ref.child('film').child(website_link + "/category").get();
    if (sinopsis.exists) {
      final link = await ref.child('film').child(website_link + "/link").get();
      final name = await ref.child('film').child(website_link + "/name").get();
      final cast =
          await ref.child('film').child(website_link + "/castlist").get();
      List<dynamic>? castList = cast.value as List<dynamic>?;
      title = [
        link.value.toString(),
        name.value.toString(),
        rating.value.toString(),
        category.value.toString(),
        sinopsis.value.toString(),
        castList,
      ];
    } else {
      var url = Uri.parse('https://www.themoviedb.org/movie/' + website_link);
      var response = await http.get(url);
      BeautifulSoup bs = await BeautifulSoup(response.body);
      bs = await BeautifulSoup(response.body);
      final link = await ref.child('film/${website_link}/link').get();
      String link_ = link.value.toString();
      final allHeaderName =
          bs.find('div.title.ott_true a') ?? bs.find('div.title.ott_false a');
      String allHeaderName_ = allHeaderName!.getText();
      final characters = bs.findAll('ol.people li.card');
      var castList = characters.map((characters) {
        return [
          characters
              .find('p', class_: 'character')!
              .findPreviousElement('p')!
              .find('a')!
              .text,
          characters.find('p', class_: 'character')!.text
        ];
      }).toList();
      final sinopsis = bs.find('div', class_: 'overview')!.find('p')!.getText();
      title = [
        link_,
        allHeaderName_,
        rating.value.toString(),
        category.value.toString(),
        sinopsis,
        castList,
      ];
      ref.child('film').child(website_link).update(
          {'name': allHeaderName_, 'sinopsis': sinopsis, 'castlist': castList});
    }
  }

  title_(index1) {
    if (index1 == -1) {
      return title;
    }
    return title[index1];
  }

  Future<void> show_schedule() async {
    List<dynamic> dates = await getvalue('dates');
    for (int i = 0; i < dates.length; i++) {
      dates.sort((a, b) {
        List<String> partsA = a.split("-");
        List<String> partsB = b.split("-");
        int dayA = int.parse(partsA[0]);
        int dayB = int.parse(partsB[0]);
        return dayA.compareTo(dayB);
      });
      title.add([dates[i]]);
      final cinemas = await getvalue("/dates/" + dates[i]);
      for (int y = 0; y < cinemas.length; y++) {
        List<dynamic> time =
            await getvalue("/dates/" + dates[i] + "/" + cinemas[y]);
        List<int> time_ = time
            .where((element) => element != "price")
            .map((dynamic element) => int.parse(element))
            .toList();
        time_.sort();
        title[i].add([cinemas[y]]);
        title[i][y + 1].add(time_);
      }
    }
  }

  Future<List<dynamic>> getvalue(childs) async {
    final all = await ref.child('film').child(website_link).child(childs).get();
    Map<dynamic, dynamic> all_ = all.value as Map<dynamic, dynamic>;
    return all_.keys.toList();
  }
}
