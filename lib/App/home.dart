// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:practice/App/Widgets/button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: Column(
        children: const [
          Align(
            alignment: Alignment.topCenter,
          ),
          Image(
            image: AssetImage("assets/images/img.png"),
            width: 300,
            height: 300,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Choice Products",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Button()
        ],
      ),
    )));
  }
}
