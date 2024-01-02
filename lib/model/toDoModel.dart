import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  String? id;
  String userId;
  String title;
  String description;
  Timestamp deadline;

  ToDo(
      {this.id,
      required this.userId,
      required this.title,
      required this.description,
      required this.deadline});

  factory ToDo.fromMap(String id, Map<String, dynamic> map) {
    return ToDo(
      id: id,
      userId: map['userId'],
      title: map['title'],
      description: map['description'],
      deadline: map['deadline'],
    );
  }
}
