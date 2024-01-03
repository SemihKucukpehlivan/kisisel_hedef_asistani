import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisisel_hedef_asistani/screens/chartGraphic.dart';
import 'package:kisisel_hedef_asistani/screens/listTodoScreen.dart';
import 'package:kisisel_hedef_asistani/screens/loginAndSignUpScreen/loginScreen.dart';
import 'package:kisisel_hedef_asistani/screens/stepCounter.dart';
import 'package:kisisel_hedef_asistani/screens/stopWatchScreen.dart';
import 'package:kisisel_hedef_asistani/widgets/cardWidget.dart';

// ignore: must_be_immutable
class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 133, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Personal Goal Assistant",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.white),
                      ),
                      IconButton(
                          onPressed: ()async{
                            await _auth.signOut();
                            _navigateToHomePage(context);
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.red,
                            size: 35,
                          ))
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CardWidget(
                          title: "Pedometer",
                          nextPage: PedometerScreen(),
                          imagePath: "assets/images/exercise.png"),
                      CardWidget(
                          title: "To Do",
                          nextPage: TodoListScreen(),
                          imagePath: "assets/images/todoImage.png")
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CardWidget(
                          title: 'Stopwatch',
                          nextPage: StopWatchScreen(),
                          imagePath: "assets/images/stopwatch.png"),
                      const CardWidget(
                          title: "Graphics",
                          nextPage: ChartGraphics(),
                          imagePath: "assets/images/grafik.png")
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
    void _navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()), // AnaSayfa yerine istediğiniz sayfayı ekleyebilirsiniz.
    );
  }
}
