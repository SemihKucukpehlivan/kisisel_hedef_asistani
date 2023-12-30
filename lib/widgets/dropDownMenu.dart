import 'package:flutter/material.dart';

class DropDownMenuWidgets extends StatefulWidget {
  const DropDownMenuWidgets({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DropDownMenuWidgetsState createState() => _DropDownMenuWidgetsState();
}

class _DropDownMenuWidgetsState extends State<DropDownMenuWidgets> {
  String exerciseDuration = '30 Minutes';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Exercise Duration: $exerciseDuration',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        DropdownButton<String>(
          value: exerciseDuration,
          onChanged: (String? newValue) {
            setState(() {
              exerciseDuration = newValue!;
            });
          },
          iconSize: 50,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          items: [
            '15 Minutes',
            '30 Minutes',
            '45 Minutes',
            '1 Hour',
            '90 Minutes',
            '2 Hours',
            '150 Minutes',
            '3 Hours',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
