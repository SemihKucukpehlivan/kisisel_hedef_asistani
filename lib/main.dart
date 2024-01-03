import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kisisel_hedef_asistani/api/firebaseApi.dart';
import 'package:kisisel_hedef_asistani/firebase_options.dart';
import 'package:kisisel_hedef_asistani/screens/loginAndSignUpScreen/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  LoginScreen(),
    );
  }
}
