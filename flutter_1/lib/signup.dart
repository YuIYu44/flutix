import 'package:flutter_1/login.dart';
import 'functions.dart';
import 'package:flutter/material.dart';

final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController emailController = TextEditingController();

class signup extends StatefulWidget {
  State<signup> createState() => _signup();
}

class _signup extends State<signup> {
  String errorText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                MediaQuery.of(context).size.height * 0.5,
                14,
                Colors.black,
                FontWeight.bold),
            textfields(
                context,
                passwordController,
                false,
                'Password',
                MediaQuery.of(context).size.height * 0.6,
                14,
                Colors.black,
                FontWeight.bold),
            if (errorText != "")
              texts_exo(
                  context,
                  errorText,
                  13,
                  MediaQuery.of(context).size.height * 0.73,
                  0,
                  MediaQuery.of(context).size.width * 0.16,
                  0,
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
                Color.fromRGBO(255, 255, 255, 1.0), () {
              setState(() {
                //if (email ada)
                errorText = "Account already exist!";
                //Else
                errorText = "Please check your input!";
              });
              go_to(context, login());
            }),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.06,
              left: MediaQuery.of(context).size.width * 0.15,
              child: GestureDetector(
                onTap: () {
                  go_to(context, login());
                },
                child: Text(
                  "I already have an account",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1.0),
                    fontSize: 14,
                    fontFamily: 'Exo',
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
