import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisisel_hedef_asistani/model/toDoModel.dart';
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
      TextEditingController(text: "Select Deadline");

  final FirestoreService firestoreService = FirestoreService();

  DateTime? picked;
  Timestamp? deadlineTimeStamp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 133, 1),
      appBar: AppBar(
        title: const Text(
          "Create Events Page",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 75),
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  TextInputContainer(
                    label: "Title",
                    controller: _titleController,
                    hintText: "Please Enter Exercise Title",
                  ),
                  TextInputContainer(
                    label: "Description",
                    controller: _descriptionController,
                    hintText: "Please Enter Exercise Description",
                    lines: 3,
                  ),
                  TextInputContainer(
                    label: "Deadline Date",
                    controller: _dateController,
                    hintText: "Select Deadline",
                    isEnabled: false,
                    onTap: _datePick,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () {
                              setState(() {
                                _titleController.clear();
                                _descriptionController.clear();
                                _dateController.clear();
                              });
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            )),
                      ),
                      // Save Button
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
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
                                deadline: deadlineTimeStamp ?? Timestamp.now(),
                              );

                              await firestoreService.addTodo(newTodo, userId);

                              // ignore: use_build_context_synchronously
                              Navigator.pop(context, true);
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
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
