import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:beautiful_soup_dart/beautiful_soup.dart';

abstract class StorageState {}

class StorageInitialState extends StorageState {}

class StorageCubit extends Cubit<StorageState> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  StorageCubit() : super(StorageInitialState());

  Future<String> downloadFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/titles.csv');
    String fileToDownload = 'titles.csv';
    try {
      await _storage.ref(fileToDownload).writeToFile(downloadToFile);
      return '${appDocDir.path}/titles.csv';
    } catch (e) {
      print('Download error: $e');
      return '';
    }
  }

  void up_file_firebase() async {
    String path = await downloadFile();
    if (path != '') {
      final file = File(path);
      List<List<dynamic>> data =
          const CsvToListConverter().convert(file.readAsStringSync());
      for (int i = 0; i < data.length; i++) {
        var url = Uri.parse('https://www.themoviedb.org/movie/' + data[i][0]);
        var response = await http.get(url);
        BeautifulSoup bs = BeautifulSoup(response.body);
        final allHeaderName =
            bs.find('div.title.ott_true a') ?? bs.find('div.title.ott_false a');
        // final sinopsis=
        //     bs.find('div.title.ott_true a') ?? bs.find('div.title.ott_false a');
        final characters = bs.findAll('ol.people li.card');
        var castList = characters.map((characters) {
          return [
            characters.find('a')?.text ?? '',
            characters.find('p.character')?.text ?? ''
          ];
        }).toList();
        print(castList);
        // final city = <String, String>{
        //   "name": allHeaderName!.text,
        //   "link": data[i][0],
        //   "sinopsis": sinopsis,
        //   "country": "USA"
        // };
      }
    }
  }
}
