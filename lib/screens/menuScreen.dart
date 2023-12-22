import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("KSA"),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCard(context, "Toplam"),
                  _buildCard(context, "Hedefler"),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCard(context, "BMI Hesaplama"),
                  _buildCard(context, "Takvim"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.green,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        shadowColor: Colors.green,
        semanticContainer: false,
        elevation: 100.0,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
