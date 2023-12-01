import 'package:flutter/material.dart';
import 'package:std_ass/time_table/add_class.dart';

class SetTimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Timetable'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add a button for each day of the week
          ElevatedButton(
            onPressed: () {
              _navigateToAddClass(context, 'Monday');
            },
            child: Text('Monday'),
          ),
          ElevatedButton(
            onPressed: () {
              _navigateToAddClass(context, 'Tuesday');
            },
            child: Text('Tuesday'),
          ),
          ElevatedButton(
            onPressed: () {
              _navigateToAddClass(context, 'Wednesday');
            },
            child: Text('Wednesday'),
          ),
          ElevatedButton(
            onPressed: () {
              _navigateToAddClass(context, 'Thursday');
            },
            child: Text('Thursday'),
          ),
          ElevatedButton(
            onPressed: () {
              _navigateToAddClass(context, 'Friday');
            },
            child: Text('Friday'),
          ),
          ElevatedButton(
            onPressed: () {
              _navigateToAddClass(context, 'Saturday');
            },
            child: Text('Saturday'),
          ),
        ],
      ),
    );
  }

  void _navigateToAddClass(BuildContext context, String day) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddClassScreen(day: day),
      ),
    );
  }
}
