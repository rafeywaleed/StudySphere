import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Introscreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(33, 144, 150, 1),
      child: Lottie.network(
          'https://lottie.host/2acab050-a7ef-48e1-a5ff-e73875f19ce9/1ZclkaP0sx.json'),
    );
  }
}
