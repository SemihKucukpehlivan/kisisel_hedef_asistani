import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kisisel_hedef_asistani/model/model.dart';
import 'package:kisisel_hedef_asistani/screens/createToDoScreen.dart';
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
      backgroundColor: const Color.fromARGB(255, 27, 133, 1),
      appBar: AppBar(
        title: const Text(
          "To Do Lists",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.transparent,
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
                return Dismissible(
                  key: Key(todo.id!),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      _editTodo(todo);
                    } else {
                      _deleteTodo(todo);
                    }
                  },
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.blue,
                    child: const Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.save,
                        color: Colors.white,
                        size: 75,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 75,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todo.description,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateToDoScreen(),
          ));
          if (result == true) {
            _refreshTodos();
          }
        },
        child: Icon(
          Icons.add,
          size: 50,
        ),
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
