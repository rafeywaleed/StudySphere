import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:std_ass/habits/alert_box.dart';
import 'package:std_ass/habits/date_time.dart';
import 'package:std_ass/habits/fab.dart';
import 'package:std_ass/habits/habit_tile.dart';
import 'package:std_ass/habits/monthly_summary.dart';

class Habits extends StatefulWidget {
  const Habits({Key? key}) : super(key: key);

  @override
  _HabitsScreenState createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<Habits> {
  final CollectionReference habitCollection =
      FirebaseFirestore.instance.collection('habits');

  List<List<dynamic>> todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

  TextEditingController _newHabitNameController = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    final habitData = await habitCollection.doc('TODAYS_HABIT_LIST').get();

    todaysHabitList = habitData.exists
        ? List<List<dynamic>>.from(habitData['todaysHabitList'])
        : [];

    for (int i = 0; i < todaysHabitList.length; i++) {
      todaysHabitList[i][1] = false;
    }

    await updateDatabase();
  }

  Future<void> updateDatabase() async {
    await habitCollection.doc('TODAYS_HABIT_LIST').set({
      'todaysHabitList': todaysHabitList,
    });

    await calculateHabitPercentage();
    await loadHeatMap();
  }

  Future<void> calculateHabitPercentage() async {
    int countCompleted = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] == true) {
        countCompleted++;
      }
    }

    String percent = todaysHabitList.isEmpty
        ? '0.0'
        : (countCompleted / todaysHabitList.length).toStringAsFixed(1);

    await habitCollection.doc('PERCENTAGE_SUMMARY').set({
      'date': todaysDateFormatted(),
      'percentage': percent,
    });
  }

  Future<void> loadHeatMap() async {
    final startDateData = await habitCollection.doc('START_DATE').get();

    DateTime startDate = createDateTimeObject(startDateData['start_date']);

    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        (await habitCollection
                .doc("PERCENTAGE_SUMMARY$yyyymmdd")
                .get())['percentage'] ??
            "0.0",
      );

      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }

  bool habitCompleted = false;

  void checkBoxTapped(bool? value, int index) {
    todaysHabitList[index][1] = value;
    updateDatabase();
  }

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: 'Enter Habit Name..',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  Future<void> saveNewHabit() async {
    setState(() {
      todaysHabitList.add([_newHabitNameController.text, false]);
    });
    await updateDatabase();
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  void cancelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: todaysHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  Future<void> saveExistingHabit(int index) async {
    todaysHabitList[index][0] = _newHabitNameController.text;
    await updateDatabase();
    _newHabitNameController.clear();
    Navigator.pop(context);
  }

  void deleteHabit(int index) {
    todaysHabitList.removeAt(index);
    updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      body: ListView(
        children: [
          MonthlySummary(
            datasets: heatMapDataSet,
            startDate: todaysDateFormatted(),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: todaysHabitList[index][0],
                habitCompleted: todaysHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
