import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  String userId;
  String title;
  String description;
  Timestamp deadline;


  ToDo({
    required this.userId,
    required this.title,
    required this.description,
    required this.deadline
  });
}
