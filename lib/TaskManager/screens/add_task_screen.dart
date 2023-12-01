import 'package:flutter/material.dart';
import 'package:std_ass/Data_Base/database.dart';
import 'package:std_ass/TaskManager/helpers/database_helper.dart';
import 'package:std_ass/TaskManager/models/task_model.dart';
import 'package:toast/toast.dart';
import 'home_screen.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


class AddTaskScreen extends StatefulWidget {
  final Function updateTaskList;
  final Task task;

  AddTaskScreen({required this.updateTaskList, required this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  late String _priority;
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  final List<String> _priorities = ['Low', 'Medium', 'High'];
  
  var uuid = Uuid();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _title = widget.task.title;
      _date = widget.task.date;
      _priority = widget.task.priority;
    }

    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

 _delete() {
  if (widget.task != null) {
    DatabaseHelper.instance.deleteTask(widget.task!.id);
    Navigator.pop(context);
    widget.updateTaskList();
    Toast.show(
      "Task Deleted",
      textStyle: context,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
    );
  }
}





_submit() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    print('$_title, $_date, $_priority');

    Task task = Task(
      title: _title,
      date: _date,
      priority: _priority,
      status: 0, // Set the initial status for a new task
      id: uuid.v4(), // Generate a unique ID for the new task
    );

    if (widget.task != null) {
      // If it's an existing task, update the task properties
      task.id = widget.task!.id;
      task.status = widget.task!.status;
    }

    if (widget.task == null) {
      // Insert the task into our user's database
      await DatabaseHelper.instance.addTask(task);
      Toast.show("New Task Added", textStyle: context, duration: Toast.lengthLong, gravity: Toast.bottom);
    } else {
      // Update the task
      await DatabaseHelper.instance.updateTask(task);
      Toast.show("Task Updated", textStyle: context, duration: Toast.lengthLong, gravity: Toast.bottom);
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    widget.updateTaskList();
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Row(children: [
          Text(
            widget.task == null ? 'Add Task' : 'Update Task',
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ]),
        centerTitle: false,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please enter a task title'
                              : null,
                          onSaved: (input) => _title = input!,
                          initialValue: _title,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          style: TextStyle(fontSize: 18.0),
                          onTap: _handleDatePicker,
                          decoration: InputDecoration(
                            labelText: 'Date',
                            labelStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: DropdownButtonFormField(
                          isDense: true,
                          icon: Icon(Icons.arrow_drop_down_circle),
                          iconSize: 22.0,
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: _priorities.map((String priority) {
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            );
                          }).toList(),
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            labelStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (input) => _priority == null
                              ? 'Please select a priority level'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _priority = value!;
                            });
                          },
                          value: _priority,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            widget.task == null ? 'Add' : 'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: _submit,
                        ),
                      ),
                      widget.task != null
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              height: 60.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.redAccent,
                                ),
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                onPressed: _delete,
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
