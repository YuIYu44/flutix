import 'dart:io';
import 'package:csv/csv.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:beautiful_soup_dart/beautiful_soup.dart';

class Storage {
  List<String> link = [];
  List<String> link_coming_soon = [];
  List<List<dynamic>> data = [];
  List<List<dynamic>> coming_soon = [];
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final db = FirebaseDatabase.instance;
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

  Future<void> up_file_firebase() async {
    String path2 = await downloadFile('coming_soon.csv');
    String path = await downloadFile('titles.csv');
    if (path != '') {
      File file = File(path);
      data = const CsvToListConverter().convert(file.readAsStringSync());
      file = File(path2);
      coming_soon = const CsvToListConverter().convert(file.readAsStringSync());
      for (int a = 0; a < data.length; a++) {
        try {
          DatabaseReference _dbRef = db.ref();
          _dbRef
              .child("film")
              .child(data[a][0])
              .once()
              .then((DatabaseEvent databaseEvent) {
            if (databaseEvent.snapshot.value == null) {
              List<String> dateList = data[a][2].split(',');

              for (int dates = 0; dates < dateList.length; dates++) {
                List<String> cinemaList = data[a][3].split(',');
                _dbRef
                    .child("film")
                    .child(data[a][0])
                    .set({'category': data[a][1]});
                for (int cinemas = 0; cinemas < cinemaList.length; cinemas++) {
                  List<String> priceList =
                      data[a][data[a].length - 1].split(',');
                  _dbRef
                      .child("film")
                      .child(data[a][0])
                      .child(dateList[dates])
                      .child(cinemaList[cinemas])
                      .set({"price": priceList[cinemas]});

                  List<String> timeList = data[a][4 + cinemas].split(',');

                  for (int times = 0; times < timeList.length; times++) {
                    _dbRef
                        .child("film")
                        .child(data[a][0])
                        .child(dateList[dates])
                        .child(cinemaList[cinemas])
                        .child(timeList[times].toString())
                        .set({
                      "seat": 0,
                    });
                  }
                }
              }
            }
          });
        } catch (e) {
          print("error");
        }
      }
    }
  }

  Future<void> image(category) async {
    final snapshot =
        await db.ref().child('film').child(data[0][0] + r'/link').get();
    if (!snapshot.exists) {
      await image2(category, data, link);
      for (int a = 0; a < data.length; a++) {
        db.ref().child('film').child(data[a][0]).update({
          'link': link[a],
        });
      }
    } else {
      for (int a = 0; a < data.length; a++) {
        final snapshots = await db.ref().child('film/${data[a][0]}/link').get();
        if (snapshots.exists && data[a][1].contains(category)) {
          link.add(snapshots.value.toString());
        }
      }
    }
    await image2(category, coming_soon, link_coming_soon);
  }

  Future<void> image2(category, datas, links) async {
    for (int a = 0; a < datas.length; a++) {
      if (datas[a][1].contains(category)) {
        var url = Uri.parse('https://www.themoviedb.org/movie/' + datas[a][0]);
        var response = await http.get(url);
        BeautifulSoup bs = await BeautifulSoup(response.body);
        var Image_link = await bs.findAll('img', attrs: {'src': true});
        for (var element in Image_link) {
          String src = element.attributes['src']!;
          if (src.contains('/t/p/w300_and_h450_bestv2_filter(blur)/')) {
            src = src.replaceAll("_filter(blur)", "");
            String link_ = "https://image.tmdb.org$src";
            links.add(link_);
            break;
          }
        }
      }
    }
  }

  String Image_(index) {
    return link[index];
  }

  String Image_coming_soon(index) {
    return link_coming_soon[index];
  }
}
