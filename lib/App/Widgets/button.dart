// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:practice/App/signin.dart';
import 'package:practice/App/signup.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      },
      style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Color.fromARGB(255, 75, 96, 183)),
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 75, vertical: 15)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))))),
      child: Text(
        "Continue",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
