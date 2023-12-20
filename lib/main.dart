import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kisisel_hedef_asistani/firebase_options.dart';
import 'package:kisisel_hedef_asistani/screens/LoginAndSignUpScreen/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoginScreen(),
    );
  }
}
