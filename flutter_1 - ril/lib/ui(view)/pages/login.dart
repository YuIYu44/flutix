import 'package:flutter/material.dart';
import 'package:flutter_1/bloc(modelview)/user_.dart';
import 'package:flutter_1/services/services.dart';
import 'package:flutter_1/ui(view)/main.dart';
import 'signup.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';
import 'userprofiling.dart';

class login extends StatefulWidget {
  State<login> createState() => _login();
}

class _login extends State<login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                child: Image.asset(
                  'asset/login.png',
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
              texts_bubble(
                  context,
                  'Log In',
                  30.0,
                  MediaQuery.of(context).size.height * 0.3,
                  0,
                  0,
                  0,
                  Color.fromRGBO(0, 0, 0, 1.0),
                  TextAlign.center),
              textfields(
                  context,
                  emailController,
                  false,
                  'Email',
                  MediaQuery.of(context).size.height * 0.45,
                  14,
                  Colors.black,
                  FontWeight.bold),
              textfields(
                  context,
                  passwordController,
                  true,
                  'Password',
                  MediaQuery.of(context).size.height * 0.55,
                  14,
                  Colors.black,
                  FontWeight.bold),
              texts_exo(
                  context,
                  error,
                  13,
                  MediaQuery.of(context).size.height * 0.63,
                  0,
                  MediaQuery.of(context).size.width * 0.16,
                  MediaQuery.of(context).size.width * 0.13,
                  Colors.red,
                  TextAlign.left,
                  FontWeight.bold),
              customButton(
                  context,
                  'Log In',
                  MediaQuery.of(context).size.height * 0.82,
                  MediaQuery.of(context).size.width * 0.7,
                  45,
                  Color(0xff4A9DFF),
                  Color.fromRGBO(255, 255, 255, 1.0), () async {
                error = await AutServices.signIn(
                    emailController.text, passwordController.text);
                setState(() {
                  error = error;
                });
                if (error == "") {
                  user_().update_shared(
                      [emailController.text, passwordController.text]);
                  if ((await AutServices.genre_exist(emailController.text)) ==
                      false) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                userprofiling()));
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (Route<dynamic> route) => false);
                  }
                }
              }),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.07,
                left: MediaQuery.of(context).size.width * 0.15,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => signup()));
                  },
                  child: Text(
                    "Don't have account yet?",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1.0),
                      fontSize: 15,
                      fontFamily: 'Exo',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
