import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kisisel_hedef_asistani/model/stopwatchModel.dart';
import 'package:kisisel_hedef_asistani/model/toDoModel.dart';
import 'package:kisisel_hedef_asistani/model/pedometerModel.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addTodo(ToDo todo, String userId) async {
    try {
      CollectionReference todosCollection = firestore.collection('todos');
      await todosCollection.add({
        'userId': userId,
        'title': todo.title,
        'description': todo.description,
        'deadline': todo.deadline,
      });
      Fluttertoast.showToast(msg: "ToDo added successfully");
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error adding ToDo: $e", toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<List<ToDo>> getTodos(String userId) async {
    List<ToDo> todoList = [];
    QuerySnapshot querySnapshot = await firestore
        .collection('todos')
        .where('userId', isEqualTo: userId)
        .get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      String id = documentSnapshot.id;
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      ToDo todo = ToDo.fromMap(id, data);
      todoList.add(todo);
    }
    return todoList;
  }

  Future<void> updateTodo(ToDo todo) async {
    try {
      CollectionReference todosCollection = firestore.collection('todos');

      // ToDo'nun referansını alıyoruz
      DocumentReference documentReference = todosCollection.doc(todo.id);

      // ToDo'yu güncelliyoruz
      await documentReference.update({
        'title': todo.title,
        'description': todo.description,
        'deadline': todo.deadline,
      });

      Fluttertoast.showToast(msg: "ToDo updated successfully");
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error updating ToDo: $e", toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> deleteTodo(String todoId) async {
    try {
      CollectionReference todosCollection = firestore.collection('todos');

      // ToDo'nun referansını alıyoruz
      DocumentReference documentReference = todosCollection.doc(todoId);

      // ToDo'yu siliyoruz
      await documentReference.delete();

      Fluttertoast.showToast(msg: "ToDo deleted successfully");
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error deleting ToDo: $e", toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> saveTime(StopwatchData stopwatch, String userId) async {
    try {
      CollectionReference times = firestore.collection("stopwatch_times");

      await times.add({
        "time": stopwatch.time,
        "timestamp": stopwatch.timestamp,
        "userId": userId,
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error saving time: $e",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> addPedometer(
      PedometerModel pedometerModel, String userId) async {
    try {
      CollectionReference pedometerCollection =
          FirebaseFirestore.instance.collection("pedometer");

      await pedometerCollection.add({
        "userId": userId,
        "day": pedometerModel.day,
        "steps": pedometerModel.steps,
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: "Error! Data not saved $e");
    }
  }
}
