import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:std_ass/time_table/class_model.dart';
//import 'package:std_ass/time_table/add_class.dart';
import 'package:std_ass/time_table/set_timetable.dart';

class TimetableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  late CollectionReference<Map<String, dynamic>> _timetableCollection;

  @override
  void initState() {
    super.initState();
    _timetableCollection = FirebaseFirestore.instance.collection('timetable');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timetable'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Timetable for the Week',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),

            // Display timetable using StreamBuilder
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _timetableCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    var timetableData = snapshot.data!.docs
                        .map((doc) => ClassModel.fromMap(doc.data()))
                        .toList();

                    return ListView.builder(
                      itemCount: timetableData.length,
                      itemBuilder: (context, index) {
                        ClassModel classData = timetableData[index];
                        return ListTile(
                          title: Text('Day ${classData.day}'),
                          subtitle: Text(
                              'Class: ${classData.className}, Time: ${classData.classTime}'),
                        );
                      },
                    );
                  } else {
                    return Text('No data available.');
                  }
                },
              ),
            ),

            // Add a button to set or edit the timetable
            ElevatedButton(
              onPressed: () {
                _navigateToSetTimetable(context);
              },
              child: Text('Set Timetable'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSetTimetable(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetTimetableScreen(),
      ),
    );
  }
}
