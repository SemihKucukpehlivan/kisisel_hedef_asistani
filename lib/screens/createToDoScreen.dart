import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisisel_hedef_asistani/model/model.dart';
import 'package:kisisel_hedef_asistani/services/firestore_service.dart';
import 'package:kisisel_hedef_asistani/widgets/textInputContainer.dart';

class CreateToDoScreen extends StatefulWidget {
  const CreateToDoScreen({super.key});

  @override
  State<CreateToDoScreen> createState() => _CreateToDoScreenState();
}

class _CreateToDoScreenState extends State<CreateToDoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _finishDate = DateTime.now();

  final FirestoreService firestoreService = FirestoreService();

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
            hintText: "Please Enter Exercise Title"),
        TextInputContainer(
            label: "Description",
            controller: _descriptionController,
            hintText: "Please Enter Exercise Title"),
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
}
