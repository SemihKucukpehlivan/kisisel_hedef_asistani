import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kisisel_hedef_asistani/model/pedometerModel.dart';
import 'package:kisisel_hedef_asistani/model/stopwatchModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartGraphics extends StatefulWidget {
  const ChartGraphics({Key? key}) : super(key: key);

  @override
  _ChartGraphicsState createState() => _ChartGraphicsState();
}

class _ChartGraphicsState extends State<ChartGraphics> {
  List<PedometerModel> stepData = [];
  List<StopwatchData> stopwatchData = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateStepData();
    _fetchStopwatchData();
  }

  void _updateStepData() async {
    if (user != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("pedometer")
              .where("userId", isEqualTo: user!.uid)
              .get();

      List<PedometerModel> newDataList =
          querySnapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
        return PedometerModel(
          doc["day"],
          doc["steps"],
        );
      }).toList();

      setState(() {
        stepData = newDataList;
      });
    }
  }

  Future<void> _fetchStopwatchData() async {
    try {
      if (user != null) {
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection("stopwatch_times")
                .where("userId", isEqualTo: user!.uid)
                .get();

        List<StopwatchData> newDataList = querySnapshot.docs
            .map((DocumentSnapshot<Map<String, dynamic>> doc) {
          return StopwatchData(
            doc["time"],
            doc["timestamp"],
          );
        }).toList();

        setState(() {
          stopwatchData = newDataList;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error fetching stopwatch data: $e",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  int _timeStringToSeconds(String timeString) {
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    return hours * 3600 + minutes * 60 + seconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 133, 1),
      appBar: AppBar(
        title: const Text(
          "Graphics",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                color: Colors.white,
              ),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: 'Step Count'),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries<PedometerModel, String>>[
                  LineSeries<PedometerModel, String>(
                    dataSource: stepData,
                    xValueMapper: (PedometerModel steps, _) => steps.day,
                    yValueMapper: (PedometerModel steps, _) => steps.steps,
                    name: 'steps',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                color: Colors.white,
              ),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: 'Stopwatch Times'),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries>[
                  ScatterSeries<StopwatchData, String>(
                    dataSource: stopwatchData,
                    yValueMapper: (StopwatchData data, _) {
                      // Assuming data.time is a String representing a time duration (e.g., "00:00:02")
                      return _timeStringToSeconds(data.time);
                    },
                    xValueMapper: (StopwatchData data, _) {
                      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                          data.timestamp.millisecondsSinceEpoch);
                      String month = dateTime.month.toString().padLeft(2, '0');
                      String day = dateTime.day.toString().padLeft(2, '0');
                      return '$month-$day';
                    },
                    name: 'Stopwatch Times',
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
