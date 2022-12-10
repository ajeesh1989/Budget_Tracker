import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
              '"NEVER SPEND YOUR MONEY BEFORE YOU HAVE EARNED IT."',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            // SizedBox(
            //   width: 500,
            //   child: Lottie.network(
            //       'https://assets6.lottiefiles.com/packages/lf20_w52qjn69.json'),
            // ),

            Image.asset(
              'lib/images/3.gif',
              // height: 400,
            )
          ],
        ),
      ),
    );
  }
}
