// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/App/signin.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void signOut() async {
    final auth = FirebaseAuth.instance;

    await auth.signOut().whenComplete(() => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn())));
  }

  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 75, 96, 183),
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Color.fromARGB(255, 75, 96, 183),
        actions: [
          IconButton(
              onPressed: () {
                signOut();
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Text(
              "Hello, ",
              style: TextStyle(fontSize: 30),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: fireStore.collection("users").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('No users available');
                }
                return Expanded(
                    child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> userMap = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(userMap["name"]),
                    );
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
