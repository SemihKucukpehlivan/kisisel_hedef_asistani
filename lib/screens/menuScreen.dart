import 'package:flutter/material.dart';
import 'package:kisisel_hedef_asistani/screens/chartGraphic.dart';
import 'package:kisisel_hedef_asistani/screens/listTodoScreen.dart';
import 'package:kisisel_hedef_asistani/screens/pedometerScreen.dart';
import 'package:kisisel_hedef_asistani/screens/stopWatchScreen.dart';
import 'package:kisisel_hedef_asistani/widgets/cardWidget.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

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
                  const Text(
                    "Personal Goal Assistant",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CardWidget(
                          title: "Exercise",
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
                      CardWidget(
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
}
