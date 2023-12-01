import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:std_ass/time_table/class_model.dart';

class TimeTableDatabase {
  final CollectionReference _classCollection =
      FirebaseFirestore.instance.collection('classes');

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
}
