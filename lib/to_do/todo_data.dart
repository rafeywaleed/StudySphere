import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoDataBase {
  late List<List<dynamic>> toDoList;
  late String userId; // User ID for associating tasks with users

  // Reference the Firestore collection
  final CollectionReference _todoCollection =
      FirebaseFirestore.instance.collection('todos');

  // Constructor to receive the user ID
  ToDoDataBase({required this.userId});

  // Create initial data with user ID
  Future<void> createInitialData() async {
    toDoList = [
      ["Create your Task", false]
    ];
    await updateDataBase();
  }

  // Load user-specific data from Firestore
  Future<void> loadData() async {
    final querySnapshot =
        await _todoCollection.where('userId', isEqualTo: userId).get();

    toDoList = querySnapshot.docs
        .map((doc) => [doc['title'], doc['completed']])
        .toList();
  }

  // Update user-specific data in Firestore
  Future<void> updateDataBase() async {
    await _todoCollection.doc(userId).set({
      'userId': userId,
      'todos': toDoList,
    });
  }
}
