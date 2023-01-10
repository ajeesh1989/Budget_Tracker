import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

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
              '"DO NOT SAVE WHAT IS LEFT AFTER SPENDING, BUT SPEND WHAT IS LEFT AFTER SAVING."',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),

            // Lottie.network(
            //     'https://assets9.lottiefiles.com/packages/lf20_Y7IjSI2C3v.json'),
            Image.asset('lib/images/90507-money-saving.gif'),
          ],
        ),
      ),
    );
  }
}
