import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              '"MONEY WONT CREATE SUCCESS, THE FREEDOM TO MAKE IT WILL"',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            // Lottie.network(
            //     'https://assets10.lottiefiles.com/packages/lf20_l5o1uey5.json'),
            // const Text(' '),
            Image.asset(
              'lib/images/91889-budgeting.gif',
              height: 400,
            ),
          ],
        ),
      ),
    );
  }
}
