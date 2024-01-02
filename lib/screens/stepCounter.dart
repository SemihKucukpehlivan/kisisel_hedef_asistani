/* import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sensors/flutter_sensors.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StepCounter(),
    );
  }
}

class StepCounter extends StatefulWidget {
  @override
  _StepCounterState createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  bool _accelAvailable = false;
  List<double> _accelData = List.filled(3, 0.0);
  StreamSubscription? _accelSubscription;
  int stepCount = 0;

  @override
  void initState() {
    _checkAccelerometerStatus();
    super.initState();
  }

  @override
  void dispose() {
    _stopAccelerometer();
    super.dispose();
  }

  void _checkAccelerometerStatus() async {
    await SensorManager()
        .isSensorAvailable(Sensors.ACCELEROMETER)
        .then((result) {
      setState(() {
        _accelAvailable = result;
      });
      if (_accelAvailable) {
        _startAccelerometer();
      }
    });
  }

  void _startAccelerometer() async {
    if (_accelSubscription != null) return;
    if (_accelAvailable) {
      final stream = await SensorManager().sensorUpdates(
        sensorId: Sensors.ACCELEROMETER,
        interval: Sensors.SENSOR_DELAY_FASTEST,
      );
      _accelSubscription = stream.listen((sensorEvent) {
        setState(() {
          _accelData = sensorEvent.data;

          // Adım sayma algoritması
          if (_isStep(_accelData[1])) {
            stepCount++;
          }
        });
      });
    }
  }

  bool _isStep(double yValue) {
    // Basit adım sayma algoritması
    if (yValue < -8.0) {
      return true;
    }
    return false;
  }

  void _stopAccelerometer() {
    if (_accelSubscription == null) return;
    _accelSubscription?.cancel();
    _accelSubscription = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Adım Sayısı:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$stepCount',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
 */