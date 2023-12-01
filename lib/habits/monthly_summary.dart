import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart'; // Import HeatMap and ColorMode
import 'package:std_ass/habits/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode
            .color, // Correct the typo here (colorMode instead of colormode)
        defaultColor: Colors.grey,
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable:
            true, // Correct the typo here (scrollable instead of Scrollable)
        size: 30,
        colorsets: const {
          1: Color.fromARGB(20, 2, 179, 8),
          2: Color.fromARGB(40, 2, 179, 8),
          3: Color.fromARGB(60, 2, 179, 8),
          4: Color.fromARGB(80, 2, 179, 8),
          5: Color.fromARGB(100, 2, 179, 8),
          6: Color.fromARGB(120, 2, 179, 8),
          7: Color.fromARGB(140, 2, 179, 8),
          8: Color.fromARGB(160, 2, 179, 8),
          9: Color.fromARGB(180, 2, 179, 8),
          10: Color.fromARGB(200, 2, 179, 8),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
