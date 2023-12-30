import 'package:flutter/material.dart';
import 'package:kisisel_hedef_asistani/model/model.dart';

class SliderWidget extends StatefulWidget {
  final ToDo toDo;

  const SliderWidget({Key? key, required this.toDo}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late double runningDistance;

  @override
  void initState() {
    super.initState();
    runningDistance = widget.toDo.runningDistance;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Running Distance: ${runningDistance.toStringAsFixed(2)} km',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Slider(
          value: runningDistance,
          min: 1.0,
          max: 30.0,
          onChanged: (value) {
            setState(() {
              runningDistance = value;
              // Slider değeri değiştiğinde ToDo nesnesine yansıtılıyor
              widget.toDo.runningDistance = value;
            });
          },
        ),
      ],
    );
  }
}
