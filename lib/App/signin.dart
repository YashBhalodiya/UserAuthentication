// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice/App/Widgets/sizedbox.dart';
import 'package:practice/App/dashboard.dart';
import 'package:practice/App/signup.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obsecureText = true;

  void signIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      _showToast("Please fill necessary fields");
    } else {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: email)
            .where("password", isEqualTo: password)
            .get();

        if (snapshot.docs.isEmpty) {
          _showToast("User Not Found Otherwise Password is Incorrect");
        } else {
          FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password)
              .whenComplete(() => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Dashboard())));

          _showToast("LogIn Successful");
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
        if (ex.code == 'user-not-found') {
          _showToast("No user found for that email.");
        } else if (ex.code == 'wrong-password') {
          _showToast("Wrong password provided.");
          log("Wrong password provided.");
        } else {
          _showToast("Failed to sign in: ${ex.message}");
        }
      } catch (e) {
        log(e.toString());
        _showToast("An error occurred. Please try again.");
      }
    }

    // if (email == "" || password == "") {
    //   _showToast("Please fill necessary fields");
    // } else {
    //   try {
    //     FirebaseAuth.instance
    //         .signInWithEmailAndPassword(email: email, password: password)
    //         .whenComplete(
    //           () => Navigator.pushReplacement(context,
    //               MaterialPageRoute(builder: (context) => Dashboard())),
    //         );
    //     // Navigator.pop(context);
    //   } on FirebaseAuthException catch (ex) {
    //     log(ex.code.toString());
    //     _showToast("User SignIn Successfully");
    //   }
    // }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In Your Account"),
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            height: 580,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 231, 245, 251),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                ),
                Image(
                  image: AssetImage("assets/images/cart.png"),
                  width: 200,
                  height: 200,
                ),
                SizedBoxWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(fontSize: 17),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelText: "Email",
                                errorStyle: TextStyle(fontSize: 13)),
                            // ignore: implicit_call_tearoffs
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Required"),
                              EmailValidator(errorText: "Enter Valid Email"),
                            ])),
                        SizedBoxWidget(),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: _obsecureText,
                          //add password visible functionality (done)
                          style: TextStyle(fontSize: 17),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obsecureText = !_obsecureText;
                                });
                              },
                              child: Icon(Icons.remove_red_eye_rounded),
                            ),
                            labelText: "Password",
                          ),
                          // ignore: implicit_call_tearoffs
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            MinLengthValidator(8,
                                errorText: "Contains at-least 8 letters")
                          ]),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: signIn,
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 106, 207, 251)),
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.white),
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 75, vertical: 15)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))))),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have An Account?",
                              style: TextStyle(fontSize: 15),
                            ),
                            TextButton(
                                onPressed: () {
                                  // Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.lightBlue),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
