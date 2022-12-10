import 'package:budget_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../intro screens/introscreen_one.dart';
import '../intro screens/introscreen_three.dart';
import '../intro screens/introscreen_two.dart';

class MyIntro extends StatefulWidget {
  const MyIntro({super.key});

  @override
  State<MyIntro> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyIntro> {
  final PageController _controller = PageController();

  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                index == 2 ? onLastPage = true : false;
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                    setState(() {});
                  },
                  child: const Text('skip'),
                ),
                SmoothPageIndicator(controller: _controller, count: 3),
                onLastPage == true
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const MyLogin();
                              },
                            ),
                          );
                        },
                        child: const Text('done'),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 450),
                              curve: Curves.easeIn);
                        },
                        child: const Text('next'),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
