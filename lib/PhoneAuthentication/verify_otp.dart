import 'package:flutter/material.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({super.key});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
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
              // controller: phoneNumberController,
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
                onPressed: () {},
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
