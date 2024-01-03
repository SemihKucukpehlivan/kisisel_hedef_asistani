import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kisisel_hedef_asistani/model/stopwatchModel.dart';
import 'package:kisisel_hedef_asistani/services/firestore_service.dart';

class StopWatchScreen extends StatefulWidget {
  @override
  _StopWatchScreenState createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  String _elapsedTime = "00:00:00";
  final User? _user = FirebaseAuth.instance.currentUser;
  late Timer _timer;

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 133, 1),
      appBar: AppBar(
        title: const Text(
          "Stopwatch",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 75),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _elapsedTime,
                style: const TextStyle(
                  fontSize: 75,
                ),
              ),
              const SizedBox(height: 35),
              _buildElevatedButton(
                text: "Start",
                onTap: _startStopwatch,
                color: Colors.blue,
              ),
              _buildElevatedButton(
                text: "Stop",
                onTap: _stopStopwatch,
                color: Colors.orange,
              ),
              _buildElevatedButton(
                color: Colors.red,
                onTap: _resetStopwatch,
                text: "Reset",
              ),
              _buildElevatedButton(
                text: "Save",
                onTap: _saveTimeToFirebase,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _stopStopwatch() {
    setState(() {
      _stopwatch.stop();
      _timer.cancel(); // Cancel the timer
    });
  }

  void _startStopwatch() {
    setState(() {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _updateElapsedTime();
      });
    });
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      _updateElapsedTime();
    });
  }

  void _updateElapsedTime() {
    setState(() {
      _elapsedTime = _formatTime(_stopwatch.elapsedMilliseconds);
    });
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  void _saveTimeToFirebase() async {
    if (_user != null) {
      String userUid = _user.uid;
      FirestoreService firestoreService = FirestoreService();
      StopwatchData stopwatchData =
          StopwatchData(_elapsedTime, Timestamp.now());
      await firestoreService.saveTime(stopwatchData, userUid);

      Fluttertoast.showToast(msg: "Time saved successfully");
    }
  }

  Widget _buildElevatedButton({
    required String text,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.075,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: Text(
            text,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
