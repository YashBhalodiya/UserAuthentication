import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/PhoneAuthentication/verify_otp.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  TextEditingController phoneNumberController = TextEditingController();

  void verifyOTP() async {
    String phone = phoneNumberController.text.trim();

    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (credential) {},
        verificationFailed: (ex) {
          log(ex.code.toString());
        },
        codeSent: (verificationId, resendToken) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const VerifyOTP()));
        },
        codeAutoRetrievalTimeout: ((verificationId) {}),
        phoneNumber: phone,
        timeout: const Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("SignUp Page"),
          centerTitle: true,
          backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: phoneNumberController,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                  hintText: "Enter Mobile Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15)),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.blue),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                  verifyOTP();
                },
                child: const Text(
                  "Send OTP",
                  style: TextStyle(fontSize: 23),
                ))
          ],
        ),
      ),
    );
  }
}
