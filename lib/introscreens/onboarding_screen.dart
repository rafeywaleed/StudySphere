import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:std_ass/home_page.dart';

import 'package:std_ass/introscreens/introscreen1.dart';
import 'package:std_ass/introscreens/introscreen2.dart';
import 'package:std_ass/introscreens/introscreen3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  bool _isOnboardingCompleted = false;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  void _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isOnboardingCompleted = prefs.getBool('isOnboardingCompleted');
    setState(() {
      _isOnboardingCompleted = isOnboardingCompleted ?? false;
    });
  }

  void _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOnboardingCompleted', true);
    setState(() {
      _isOnboardingCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isOnboardingCompleted) {
      return MyHomePage();
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              Introscreen1(),
              Introscreen2(),
              Introscreen3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Next
                GestureDetector(
                  onTap: () {
                    if (_controller.page == 2) {
                      _completeOnboarding();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ),
                      );
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text("Next"),
                ),

                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  axisDirection: Axis.horizontal,
                  effect: const WormEffect(
                    activeDotColor: Colors.blue,
                    dotHeight: 10,
                    dotColor: Color.fromARGB(137, 89, 86, 86),
                    dotWidth: 10,
                  ),
                ),

                // Skip
                GestureDetector(
                  onTap: () {
                    _completeOnboarding();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ),
                    );
                  },
                  child: Text("Skip"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
