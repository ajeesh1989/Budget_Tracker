import 'dart:async';
import 'package:budget_app/screens/pages/intro.dart';
import 'package:budget_app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'box.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    checkRegister(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Box(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SizedBox(
                      width: 260,
                      child: IconButton(
                        icon: Image.asset(
                            'lib/images/Screenshot 2022-11-11 231101.png'),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  const Text(
                    'BUDGET TRACKER',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> goToGetPage() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) {
      return;
    }
    Get.off(() => MyIntro());
  }

  Future<void> checkRegister(BuildContext context) async {
    final sharePrefs = await SharedPreferences.getInstance();
    final userRegistered = sharePrefs.getString('nameKey');
    if (userRegistered == null) {
      goToGetPage();
    } else {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) {
        return;
      }
      Get.off(() => BottomNavbar());
    }
  }
}
