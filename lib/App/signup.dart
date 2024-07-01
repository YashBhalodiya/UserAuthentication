// ignore_for_file: prefer_const_constructors, implicit_call_tearoffs, use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:practice/App/Widgets/sizedbox.dart';
// import 'package:practice/App/dashboard.dart';
import 'package:practice/App/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  bool _obsecureText = true;

  void signUp() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = cpasswordController.text.trim();

    Map<String, dynamic> userData = {
      "name": name,
      "email": email,
      "password": password
    };

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(name)
          .set(userData);
    } catch (ex) {
      log(ex.toString());
    }

    if (email == "" || password == "" || name == "" || confirmPassword == "") {
      _showToast("Please fill necessary fields");
    } else {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        _showToast("User Created");

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
        _showToast("Email is already in use");
      }
    }
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
        title: Text("Create New Account"),
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            height: 680,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 231, 245, 251),
                borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                  ),
                  Image(
                    image: AssetImage("assets/images/cart.png"),
                    width: 150,
                    height: 150,
                  ),
                  SizedBoxWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: [
                          TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              style: TextStyle(fontSize: 17),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                labelText: "Name",
                              ),
                              validator: MultiValidator(
                                  [RequiredValidator(errorText: "Required")])),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(fontSize: 17),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelText: "Email",
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Required"),
                                EmailValidator(errorText: "Enter Valid Email"),
                              ])),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obsecureText,
                              //add password visible functionality

                              //check about rich text
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
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Required"),
                                PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                    errorText:
                                        'passwords must have at least one special character'),
                                MinLengthValidator(8,
                                    errorText: "Contains at-least 8 letters")
                              ])),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                              controller: cpasswordController,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: _obsecureText,
                              //add password visible functionality

                              //check about rich text
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
                                labelText: "Confirm Password",
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Required"),
                                PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                    errorText:
                                        'passwords must have at least one special character'),
                                MinLengthValidator(8,
                                    errorText: "Contains at-least 8 letters")
                              ])),
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: signUp,
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
                              "Sign Up",
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
                                "Have An Account?",
                                style: TextStyle(fontSize: 15),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignIn()));
                                  },
                                  child: Text(
                                    "Sign In",
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
      ),
    );
  }
}
