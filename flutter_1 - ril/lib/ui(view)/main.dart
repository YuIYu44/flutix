import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_1/bloc(modelview)/user_.dart';
import 'package:flutter_1/firebase_options.dart';
import 'package:flutter_1/ui(view)/pages/home.dart';
import 'package:flutter_1/ui(view)/pages/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    BlocProvider(
      create: (context) => user_(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<user_>(
        create: (context) => user_(),
        child: MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          home: BlocBuilder<user_, userstate>(
            builder: (context, state) {
              if (state.uservalue[0] != "") {
                return home();
              } else {
                return splashScreen();
              }
            },
          ),
        ));
  }
}
