import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:std_ass/Authentication/login.dart';
//import 'package:std_ass/Data%20Base/database.dart';
import 'package:std_ass/Notes/notes_screens/notes_screen.dart';
import 'package:std_ass/To%20Do/pages/hidden/hidendrawer.dart';
import 'package:std_ass/habits/habits.dart';
import 'package:std_ass/time_table/set_timetable.dart';
import 'package:std_ass/time_table/timetable_screen.dart';
import 'package:std_ass/to_do/to_do.dart';
//import 'package:std_ass/introscreens/onboarding_screen.dart';
import 'package:std_ass/home_page.dart';

final routes = {
  '/to_do': (context) => ToDoScreen(),
  '/timetable': (context) => TimetableScreen(),
  '/set_timetable': (context) => SetTimetableScreen(),
  '/habit': (context) => Habits(),
  '/notes': (context) => NoteScreen(),
  '/new_todo': (context) => HidenDrawer()
};

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Replace these placeholder values with your actual Firebase project configuration
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyDV5EOzo8bbF-AcbBl2t2H8_LlUoGc37vY',
      appId: '1:240002349780:android:31c4f2931a3abb3614d941',
      messagingSenderId: '240002349780',
      projectId: 'studysphere-55215',
      // Add other configuration options
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // User is logged in, navigate to the home page or another screen.
              return MyHomePage();
            } else {
              // User is not logged in, show the login form or onboarding screen.
              return LoginForm();
            }
          },
        ),

        // Defining routes
        routes: {
          '/to_do': (context) => ToDoScreen(),
          '/timetable': (context) => TimetableScreen(),
          '/habit': (context) => Habits(),
          '/notes': (context) => NoteScreen(),
          '/new_todo': (context) => HidenDrawer(),
        });
  }
}
