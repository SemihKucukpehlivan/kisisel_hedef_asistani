import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kisisel_hedef_asistani/screens/menuScreen.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    final navigator = Navigator.of(context);

    try {
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        registerUser(email: email, password: password, name: name);
        navigator.push(
          MaterialPageRoute(
            builder: (context) => const MenuScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> signIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final navigator = Navigator.of(context);
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        navigator.push(MaterialPageRoute(
          builder: (context) => const MenuScreen(),
        ));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    await userCollection
        .doc()
        .set({"fullname": name, "mail": email, "password": password});
  }

  Future<String?> signInWithGoogle() async {
    // Oturum açma süreci
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //Süreç içersinden bilgileri al
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    // kullanıcı nesnesi
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    // kullanıcı girişini sağla
    final userCredential = await firebaseAuth.signInWithCredential(credential);
    return userCredential.user!.email;
  }
}
