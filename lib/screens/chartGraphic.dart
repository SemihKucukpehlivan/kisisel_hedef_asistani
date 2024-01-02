import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisisel_hedef_asistani/model/pedometerModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartGraphics extends StatefulWidget {
  ChartGraphics({Key? key}) : super(key: key);

  @override
  _ChartGraphicsState createState() => _ChartGraphicsState();
}

class _ChartGraphicsState extends State<ChartGraphics> {
  List<PedometerModel> data = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateData();
  }

  void _updateData() async {
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
        data = newDataList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter chart'),
      ),
      body: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        // Chart title
        title: ChartTitle(text: 'Half yearly sales analysis'),
        // Enable legend
        legend: Legend(isVisible: true),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PedometerModel, String>>[
          LineSeries<PedometerModel, String>(
            dataSource: data,
            xValueMapper: (PedometerModel steps, _) => steps.day,
            yValueMapper: (PedometerModel steps, _) => steps.steps,
            name: 'steps',
            // Enable data label
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}
