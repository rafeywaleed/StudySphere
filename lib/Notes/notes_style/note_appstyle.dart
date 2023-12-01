import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgColor = Color.fromARGB(255, 239, 223, 82);
  static Color mainColor = Color.fromARGB(255, 255, 255, 255);
  static Color accentColor = Color.fromARGB(255, 122, 168, 237);

  ///setting the cards different color
  static List<Color> cardsColor = [
    Colors.purple.shade100,
    Colors.brown.shade100,
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.grey.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.blueGrey.shade100,
  ];

  ///setting the text style
  static TextStyle mainTitle =
      GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.bold);
  static TextStyle mainContent =
      GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.normal);
  static TextStyle dateTitle =
      GoogleFonts.roboto(fontSize: 13.0, fontWeight: FontWeight.w500);
}
