import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kisisel_hedef_asistani/model/model.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addTodo(ToDo todo, String userId) async {
    try {
      CollectionReference todosCollection = firestore.collection('todos');

      await todosCollection.add({
        'userId': userId,  // Ekledik: ToDo'nun hangi kullanıcıya ait olduğunu belirtmek için userId
        'title': todo.title,
        'description': todo.description,
      });

      Fluttertoast.showToast(msg: "ToDo added successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error adding ToDo: $e", toastLength: Toast.LENGTH_LONG);
    }
  }

  // Diğer CRUD işlemleri eklenmeli (update, delete, getTodos, vb.)
}
