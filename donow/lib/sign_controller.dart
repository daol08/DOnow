import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'goalList.dart';
import 'main.dart';

late final user_email;

Future<void> signInWithGoogle(context) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  if(googleAuth != null){
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    if (googleUser != null) {
      var userbase = await firestore
          .collection("user")
          .where("email", isEqualTo: googleUser.email)
          .get();
      if (userbase.docs.isEmpty) {
        firestore
            .collection("user")
            .doc()
            .set({"name": googleUser.displayName, "email": googleUser.email});
      }
      user_email = googleUser.email;
      Navigator.push(context, MaterialPageRoute(builder: (context) => goalList()));
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }else{
    return;
  }
  // Once signed in, return the UserCredential
}
