import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './style.dart';
import 'firebase_options.dart';
import './goalList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './sign_controller.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        '나만의 목표설정&달성까지',
                        style: TextStyle(color: font_color),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      'DO\nnow',
                      style: TextStyle(
                          color: font_color, fontSize: 50, height: 0.7),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: OutlinedButton(
                    //this is for google log in
                    onPressed: () => {
                          signInWithGoogle(context),
                        },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 2.0, color: button_color),
                    ),
                    child: const Text(
                      "Log In With Google",
                      style: TextStyle(color: font_color),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
