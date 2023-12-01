import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:std_ass/time_table/class_model.dart';

class TimetableService {
  static const String _collectionName = 'timetableCollection';

  // Function to add a class to the timetable
  static Future<void> addClass(ClassModel newClass) async {
    final CollectionReference<Map<String, dynamic>> timetableCollection =
        FirebaseFirestore.instance.collection(_collectionName);

    await timetableCollection.add(newClass.toMap());
  }

  // Function to get all classes from the timetable
  static Future<List<ClassModel>> getAllClasses() async {
    final CollectionReference<Map<String, dynamic>> timetableCollection =
        FirebaseFirestore.instance.collection(_collectionName);

    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await timetableCollection.get();

    return snapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> doc) =>
            ClassModel.fromMap(doc.data()!))
        .toList();
  }

  // Function to delete a class from the timetable
  static Future<void> deleteClass(String docId) async {
    final CollectionReference<Map<String, dynamic>> timetableCollection =
        FirebaseFirestore.instance.collection(_collectionName);

    await timetableCollection.doc(docId).delete();
  }
}
