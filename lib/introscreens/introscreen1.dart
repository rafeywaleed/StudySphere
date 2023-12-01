import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Introscreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Lottie.network(
          'https://lottie.host/6307289a-cf28-4964-bbc5-40655f197f75/GOm30eKszw.json'),
    );
  }
}
