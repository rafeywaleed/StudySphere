import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:std_ass/time_table/class_model.dart';

class AddClassScreen extends StatefulWidget {
  final String day;

  AddClassScreen({required this.day});

  @override
  _AddClassScreenState createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController classTimeController = TextEditingController();

  final CollectionReference<Map<String, dynamic>> _timetableCollection =
      FirebaseFirestore.instance.collection('timetable');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Class for ${widget.day}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: classNameController,
              decoration: InputDecoration(labelText: 'Class Name'),
            ),
            TextField(
              controller: classTimeController,
              decoration: InputDecoration(labelText: 'Class Time'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await _addTimetableClass();
                Navigator.pop(context);
              },
              child: Text('Add Class'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addTimetableClass() async {
    String className = classNameController.text.trim();
    String classTime = classTimeController.text.trim();

    if (className.isNotEmpty && classTime.isNotEmpty) {
      await _timetableCollection.add({
        'day': widget.day,
        'className': className,
        'classTime': classTime,
      });
    }
  }
}
