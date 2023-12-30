import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisisel_hedef_asistani/model/model.dart';
import 'package:kisisel_hedef_asistani/services/firestore_service.dart';
import 'package:kisisel_hedef_asistani/widgets/textInputContainer.dart';

class CreateToDoScreen extends StatefulWidget {
  const CreateToDoScreen({Key? key}) : super(key: key);

  @override
  State<CreateToDoScreen> createState() => _CreateToDoScreenState();
}

class _CreateToDoScreenState extends State<CreateToDoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(text: "Please Enter Exercise Deadline");

  final FirestoreService firestoreService = FirestoreService();

  DateTime? picked;
  Timestamp? deadlineTimeStamp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Events Page"),
      ),
      body: Column(children: [
        TextInputContainer(
          label: "Title",
          controller: _titleController,
          hintText: "Please Enter Exercise Title",
        ),
        TextInputContainer(
          label: "Description",
          controller: _descriptionController,
          hintText: "Please Enter Exercise Description",
        ),
        TextInputContainer(
          label: "Deadline Date",
          controller: _dateController,
          hintText: "Please Enter Exercise Deadline",
          onTap: _datePick,
        ),
        // Save Button
        ElevatedButton(
          onPressed: () async {
            User? user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              String userId = user.uid;
              String title = _titleController.text;
              String description = _descriptionController.text;

              ToDo newTodo = ToDo(
                userId: userId,
                title: title,
                description: description,
                deadline: deadlineTimeStamp ?? Timestamp.now(), // Set the deadline here
              );

              await firestoreService.addTodo(newTodo, userId);

              Navigator.pop(context);
            }
          },
          child: const Text("Save"),
        ),
      ]),
    );
  }

  void _datePick() async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text =
            '${picked!.year} - ${picked!.month} - ${picked!.day}';
        deadlineTimeStamp = Timestamp.fromMicrosecondsSinceEpoch(
            picked!.microsecondsSinceEpoch);
      });
    }
  }
}
