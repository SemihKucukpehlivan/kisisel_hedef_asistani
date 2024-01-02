import 'package:cloud_firestore/cloud_firestore.dart';

class StopwatchData {
  final String time;
  final Timestamp timestamp;

  StopwatchData(this.time, this.timestamp);

  factory StopwatchData.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    Timestamp timestamp = data['timestamp'] as Timestamp;
    return StopwatchData(data['time'], timestamp);
  }
}
