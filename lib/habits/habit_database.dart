import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:std_ass/habits/date_time.dart';

class HabitDatabase {
  final CollectionReference _habitCollection =
      FirebaseFirestore.instance.collection('habits');

  List<List<dynamic>> todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

  Future<void> createDefaultData() async {
    todaysHabitList = [
      ["Run", false],
      ["Read", false],
    ];

    await _habitCollection.doc('START_DATE').set({
      'start_date': todaysDateFormatted(),
    });
  }

  Future<void> loadData() async {
    final habitData = await _habitCollection.doc('TODAYS_HABIT_LIST').get();

    todaysHabitList = habitData.exists
        ? List<List<dynamic>>.from(habitData['todaysHabitList'])
        : [];

    for (int i = 0; i < todaysHabitList.length; i++) {
      todaysHabitList[i][1] = false;
    }
  }

  Future<void> updateDatabase() async {
    await _habitCollection.doc('TODAYS_HABIT_LIST').set({
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

    await _habitCollection.doc('PERCENTAGE_SUMMARY').set({
      'date': todaysDateFormatted(),
      'percentage': percent,
    });
  }

  Future<void> loadHeatMap() async {
    final startDateData = await _habitCollection.doc('START_DATE').get();

    DateTime startDate = createDateTimeObject(startDateData['start_date']);

    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        (await _habitCollection
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
}
