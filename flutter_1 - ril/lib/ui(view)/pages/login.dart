import 'package:flutter/material.dart';
import 'package:flutter_1/services/services.dart';
import 'package:flutter_1/main.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Image.asset(
                  'asset/login.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              texts_bubble(context, 'Log In', 40.0, 0, 0.05, 0, 0,
                  Color.fromRGBO(0, 0, 0, 1.0), TextAlign.center),
              Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04),
                  child: textfields(context, emailController, false, 'Email', 0,
                      14, Colors.black, FontWeight.bold)),
              Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03),
                  child: textfields(context, passwordController, true,
                      'Password', 0, 14, Colors.black, FontWeight.bold)),
              texts_exo(context, error, 13, 0.05, 0.15, 0.15, 0.15, Colors.red,
                  TextAlign.left, FontWeight.bold),
              customButton(
                  context,
                  'Log In',
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
                  if ((await AutServices.genre_exist(emailController.text)) ==
                      false) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                userprofiling(emailController.text)));
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (Route<dynamic> route) => false);
                  }
                }
              }),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02),
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
