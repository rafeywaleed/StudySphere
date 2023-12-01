import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:std_ass/time_table/class_model.dart';
import 'package:std_ass/TaskManager/models/task_model.dart';

class DatabaseHelper {
  static late CollectionReference _classCollection;
  static late CollectionReference _taskCollection;

  // Singleton pattern
  static final DatabaseHelper instance = DatabaseHelper._instance();

  DatabaseHelper._instance() {
    init();
  }

  Future<void> init() async {
    FirebaseFirestore.instance.settings = Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );

    _classCollection = FirebaseFirestore.instance.collection('classes');
    _taskCollection = FirebaseFirestore.instance.collection('tasks');
  }

  // Methods related to class data
  Future<void> addClass(ClassModel newClass) async {
    await _classCollection.add(newClass.toMap());
  }

  Future<List<ClassModel>> getAllClasses() async {
    final querySnapshot = await _classCollection.get();
    return querySnapshot.docs
        .map((doc) => ClassModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteClass(String id) async {
    await _classCollection.doc(id).delete();
  }

  // Methods related to task data
  Future<void> addTask(Task task) async {
    await _taskCollection.add(task.toMap());
  }

  Future<List<Task>> getAllTasks() async {
    final querySnapshot = await _taskCollection.get();
    return querySnapshot.docs
        .map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteTask(String id) async {
    await _taskCollection.doc(id).delete();
  }

  Future<List<Task>> getTaskList() async {
    final querySnapshot = await _taskCollection.get();
    return querySnapshot.docs
        .map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
// Future<void> updateTask(Task task) async {
//   try {
//     await _taskCollection.doc(task.id).update(task.toMap());
//   } catch (e) {
//     print("Error updating task: $e");
//     // Handle the error, throw an exception, or log it as needed
//   }
// }


