part of 'services.dart';

class Storage {
  List<List<dynamic>> datas = [];
  final FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore fires = FirebaseFirestore.instance;

  Future<String> downloadFile(title) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/${title}');
    try {
      await _storage.ref(title).writeToFile(downloadToFile);
      return '${appDocDir.path}/${title}';
    } catch (e) {
      print('Download error: $e');
      return '';
    }
  }

  Future<void> make_dummy(doc_) async {
    Map<String, Object> dummyMap = Map<String, Object>();
    DocumentReference film_ = await fires.doc(doc_);
    DocumentSnapshot snapshot_ = await film_.get();
    if (!snapshot_.exists) {
      await film_.set(dummyMap);
    }
  }

  Future<void> up_file_firebase() async {
    String path2 = await downloadFile('coming_soon.csv');
    String path = await downloadFile('titles.csv');
    if (path != '') {
      File file = await File(path);
      List<List<dynamic>> datas =
          await const CsvToListConverter().convert(file.readAsStringSync());

      file = await File(path2);
      List<List<dynamic>> coming_soon =
          await const CsvToListConverter().convert(file.readAsStringSync());
      await up_file_firebase2(datas, "film");
      await up_file_firebase2(coming_soon, "coming_soon");
    }
  }

  Future<void> up_file_firebase2(data, kind) async {
    for (int a = 0; a < data.length; a++) {
      await make_dummy("films/${kind}");
      DocumentReference film = await fires.collection("films").doc(kind);
      await make_dummy("films/${kind}/name/${data[a][0]}");

      DocumentReference film_ = await film.collection("name").doc(data[a][0]);
      DocumentSnapshot snapshot_name = await film_.get();
      Map<String, dynamic> dataMap =
          snapshot_name.data() as Map<String, dynamic>;
      if (dataMap.containsKey("link") == false) {
        await image_sinopsis("", data[a][0], kind);
      }
      if (dataMap.containsKey("category") == false) {
        if (kind == "coming_soon") {
          film_ = await fires.doc("films/${kind}/name/${data[a][0]}");
          await film_.update({'category': data[a][1]});
        } else {
          if (dataMap.containsKey('rating') == false) {
            await film_.update({'available': 1});
            await film_.update({'category': data[a][1], 'rating': 0});
          }
          List<String> dateList = data[a][2].split(',');
          for (int dates = 0; dates < dateList.length; dates++) {
            List<String> cinemaList = data[a][3].split(',');
            make_dummy(
                "films/${kind}/name/${data[a][0]}/dates/${dateList[dates]}");
            DocumentReference film_1 =
                await film_.collection("dates").doc(dateList[dates]);
            for (int cinemas = 0; cinemas < cinemaList.length; cinemas++) {
              List<String> priceList = data[a][data[a].length - 1].split(',');
              DocumentReference film_2 =
                  await film_1.collection("cinema").doc(cinemaList[cinemas]);
              await film_2.set({"price": int.tryParse(priceList[cinemas])});
              List<String> timeList = data[a][4 + cinemas].split(',');

              for (int times = 0; times < timeList.length; times++) {
                DocumentSnapshot film_3 =
                    await film_2.collection("time").doc(timeList[times]).get();
                if (film_3.data() == null) {
                  await film_2.collection("time").doc(timeList[times]).set({
                    'booked': ["A8"]
                  });
                }
              }
            }
          }
        }
      }
    }
  }

  Future<void> image_sinopsis(category, data, kind) async {
    DocumentReference film_ =
        await fires.collection("films").doc(kind).collection("name").doc(data);

    var url = Uri.parse('https://www.themoviedb.org/movie/' + data);
    var response = await http.get(url);
    BeautifulSoup bs = await BeautifulSoup(response.body);
    var Image_link = await bs.findAll('img', attrs: {'src': true});
    for (var element in Image_link) {
      String src = element.attributes['src']!;

      if (src.contains('/t/p/w300_and_h450_bestv2_filter(blur)/')) {
        src = src.replaceAll("_filter(blur)", "");
        String link_ = "https://image.tmdb.org$src";
        await fires
            .collection("films")
            .doc(kind)
            .collection("name")
            .doc(data)
            .update({"link": link_});
      }
    }
    if (kind == "film") {
      final allHeaderName = await bs.find('div.title.ott_true a') ??
          bs.find('div.title.ott_false a');
      String HeaderName = await allHeaderName!.getText();
      final characters = await bs.findAll('ol.people li.card');
      var castList = await characters.map((characters) {
        return [
          characters
              .find('p', class_: 'character')!
              .findPreviousElement('p')!
              .find('a')!
              .text,
          characters.find('p', class_: 'character')!.text
        ];
      }).toList();
      var castMap = await Map.fromIterable(castList,
          key: (character) => character[0], value: (character) => character[1]);
      final sinopsis =
          await bs.find('div', class_: 'overview')!.find('p')!.getText();
      await film_.update({
        "movie_name": HeaderName,
        'sinopsis': sinopsis,
        'castlist': castMap
      });
    }
  }
}
