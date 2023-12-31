import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kisisel_hedef_asistani/model/model.dart';
import 'package:kisisel_hedef_asistani/services/firestore_service.dart';
import 'package:kisisel_hedef_asistani/widgets/textInputContainer.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  User? user = FirebaseAuth.instance.currentUser;
  late Future<List<ToDo>> _todosFuture;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: FutureBuilder<List<ToDo>>(
        future: _todosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<ToDo> todos = snapshot.data ?? [];
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                ToDo todo = todos[index];
                String formattedDate =
                    DateFormat.yMd().format(todo.deadline.toDate());
                return Card(
                  child: ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Deadline: $formattedDate"),
                        SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editTodo(todo);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteTodo(todo);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _refreshTodos() {
    setState(() {
      _todosFuture = _firestoreService.getTodos(user!.uid);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todosFuture = _firestoreService.getTodos(user!.uid);
  }

  void _editTodo(ToDo todo) {
    TextEditingController editedTitleController = TextEditingController();
    TextEditingController editedDescriptionController = TextEditingController();

    // Set initial values for editing
    editedTitleController.text = todo.title;
    editedDescriptionController.text = todo.description;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit ToDo'),
          content: Column(
            children: [
              TextInputContainer(
                label: "Title",
                controller: editedTitleController,
                hintText: "Please Enter Exercise Title",
              ),
              TextInputContainer(
                label: "Description",
                controller: editedDescriptionController,
                hintText: "Please Enter Exercise Description",
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Get updated values
                String editedTitle = editedTitleController.text;
                String editedDescription = editedDescriptionController.text;

                // Create an updated ToDo object
                ToDo updatedTodo = ToDo(
                  id: todo.id,
                  userId: todo.userId,
                  title: editedTitle,
                  description: editedDescription,
                  deadline: todo.deadline,
                );

                _refreshTodos();

                // Call the FirestoreService to update the ToDo
                await _firestoreService.updateTodo(updatedTodo);

                // Dismiss the dialog
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTodo(ToDo todo) async {
    try {
      if (todo.id != null) {
        await _firestoreService.deleteTodo(todo.id!);

        // Refresh the list after deletion
        _refreshTodos();
      } else {
        Fluttertoast.showToast(
            msg: "Error: ToDo ID is null", toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error deleting ToDo: $e", toastLength: Toast.LENGTH_LONG);
    }
  }
}
