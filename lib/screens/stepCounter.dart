import 'package:flutter/material.dart';

class PedometerScreen extends StatefulWidget {
  const PedometerScreen({super.key});

  @override
  State<PedometerScreen> createState() => _PedometerScreenState();
}

class _PedometerScreenState extends State<PedometerScreen> {
  String? stepCounter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 133, 1),
      appBar: AppBar(
        title: const Text(
          "Pedometer",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
          child: Column(
        children: [
          Image.asset("assets/images/running.png"),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                stepCounter == null
                    ? "?"
                    : stepCounter.toString(),
                style: TextStyle(fontSize: 45, color: Colors.white),
              )),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Reset",
                style: TextStyle(color: Colors.white,fontSize: 25),
              ),
            ),
          )
        ],
      )),
    );
  }
}
