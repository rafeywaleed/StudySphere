import 'package:flutter/material.dart';
import 'package:std_ass/to_do/dialog_box.dart';
import 'package:std_ass/to_do/todo_data.dart';
import 'package:std_ass/to_do/todo_tile.dart';
//import 'package:std_ass/Data%20Base/database.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  // Text Controller
  final _controller = TextEditingController();

  // Instance of ToDoDataBase
  ToDoDataBase toDoDataBase = ToDoDataBase(userId: '');

  @override
  void initState() {
    super.initState();
    // Load data when the screen is initialized
    loadData();
  }

  // CheckBox
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoDataBase.toDoList[index][1] = !toDoDataBase.toDoList[index][1];
      updateData();
    });
  }

  // Save new Task
  void saveNewTask() {
    setState(() {
      toDoDataBase.toDoList.add([_controller.text, false]);
      _controller.clear();
      updateData();
    });
    Navigator.of(context).pop();
  }

  // Load data from Firebase
  Future<void> loadData() async {
    await toDoDataBase.loadData();
    setState(() {
      // Assign the loaded data to the local variable
      toDoDataBase.toDoList = toDoDataBase.toDoList;
    });
  }

  // Update data on Firebase
  void updateData() {
    toDoDataBase.updateDataBase();
  }

  // Create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          Controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Delete Task
  void deleteTask(int index) {
    setState(() {
      toDoDataBase.toDoList.removeAt(index);
      updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 243, 211, 0.7),
      appBar: AppBar(
        title: Text(
          "To Do List",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromRGBO(243, 235, 154, 1),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoDataBase.toDoList.length,
        itemBuilder: (context, index) {
          final task = toDoDataBase.toDoList[index];
          return ToDoTile(
            taskName: task[0],
            taskCompleted: task[1],
            onChanged: (value) => checkBoxChanged(value, index),
            deletefunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
