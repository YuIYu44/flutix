import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_1/firebase_options.dart';
import 'package:flutter_1/ui(view)/pages/home.dart';
import 'package:flutter_1/ui(view)/pages/splash.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';
import 'package:flutter_1/bloc(modelview)/user_.dart';

final user = user_();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  List<String> list = await getValue();
  user.update_username_password(list);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget initialPage;
    if (user.state[0] != "") {
      initialPage = home();
    } else {
      initialPage = splashScreen();
    }

    return MaterialApp(
      home: initialPage,
    );
  }
}
