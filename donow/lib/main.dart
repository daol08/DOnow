import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './style.dart';
import 'firebase_options.dart';
import './goalList.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    if (googleUser != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => goalList()));
    }

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Column(
                  children: const [
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
                          signInWithGoogle(),
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
