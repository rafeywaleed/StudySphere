import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Introscreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(82, 186, 250, 1),
        child: Lottie.asset('animations/slide_two.json'));
  }
}
