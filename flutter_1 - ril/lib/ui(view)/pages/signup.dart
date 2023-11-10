import 'package:flutter/material.dart';
import 'package:flutter_1/services/services.dart';
import 'login.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';

class signup extends StatefulWidget {
  State<signup> createState() => _signup();
}

class _signup extends State<signup> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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
                  'asset/sign_up.png',
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
              texts_bubble(
                  context,
                  'Sign Up',
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
                  MediaQuery.of(context).size.height * 0.4,
                  14,
                  Colors.black,
                  FontWeight.bold),
              textfields(
                  context,
                  usernameController,
                  false,
                  'Username',
                  MediaQuery.of(context).size.height * 0.48,
                  14,
                  Colors.black,
                  FontWeight.bold),
              textfields(
                  context,
                  passwordController,
                  true,
                  'Password',
                  MediaQuery.of(context).size.height * 0.56,
                  14,
                  Colors.black,
                  FontWeight.bold),
              texts_exo(
                  context,
                  error,
                  13,
                  MediaQuery.of(context).size.height * 0.65,
                  0,
                  MediaQuery.of(context).size.width * 0.16,
                  MediaQuery.of(context).size.width * 0.13,
                  Colors.red,
                  TextAlign.left,
                  FontWeight.bold),
              customButton(
                  context,
                  'Create An Account',
                  MediaQuery.of(context).size.height * 0.82,
                  MediaQuery.of(context).size.width * 0.7,
                  45,
                  Color(0xff4A9DFF),
                  Color.fromRGBO(255, 255, 255, 1.0), () async {
                error = await AutServices.signUp(emailController.text,
                    passwordController.text, usernameController.text);
                setState(() {
                  if (error == "") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => login()));
                  }
                });
              }),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.07,
                left: MediaQuery.of(context).size.width * 0.15,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => login()));
                  },
                  child: Text(
                    "I already have an account",
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
