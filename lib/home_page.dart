//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:std_ass/Notes/notes_screens/notes_screen.dart';
import 'package:std_ass/To%20Do/pages/hidden/hidendrawer.dart';
import 'package:std_ass/habits/habits.dart';
import 'package:std_ass/time_table/set_timetable.dart';
import 'package:std_ass/time_table/timetable_screen.dart';
import 'package:std_ass/to_do/to_do.dart';
// ignore: unused_import
import 'package:path_provider/path_provider.dart';

final routes = {
  '/': (context) => MyHomePage(),
  '/to_do': (context) => ToDoScreen(),
  '/timetable': (context) => TimetableScreen(),
  //'/timetable': (context) => TimetableScreen(),
  '/set_timetable': (context) => SetTimetableScreen(),
  '/habit': (context) => Habits(),
  '/notes': (context) => NoteScreen(),
  '/new_todo': (context) => HidenDrawer()
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userName = 'Rafey';
  String grade = 'II year';
  int todayProductivity = 80;
  int weeklyProductivity = 75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'StudySphere',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.white,
              ),
            ),
            pinned: true,
            expandedHeight: 50.0,
            backgroundColor: Color.fromRGBO(101, 181, 215, 0.8),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 229, 229, 229),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                grade,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '$todayProductivity%',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                'Today\'s Productivity',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                '$weeklyProductivity%',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                'Weekly Productivity',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Add the styled button below the container
                Container(
                  margin: EdgeInsets.all(16.0), // Adjust left margin
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/to_do');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0), // Adjust padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // Adjust corner radius
                      ),
                    ),
                    child: Text(
                      'To Do Lists',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                // Timetable Button
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/timetable');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Timetable',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),

                // Habit Tracker Button
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/habit');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Habit Tracker',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                // Notes Button
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/notes');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Notes',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),

                // New TO DO Button
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/new_todo');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'New TO Do',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),

                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
