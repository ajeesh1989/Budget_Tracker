import 'package:budget_app/models/category/category_model.dart';
import 'package:budget_app/models/transaction/transaction_model.dart';
import 'package:budget_app/settingsSubPages/privacy.dart';
import 'package:budget_app/settingsSubPages/terms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../settingsSubPages/about.dart';
import 'intro.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.grey.shade500,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.person),
                  const SizedBox(
                    width: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    child: const Text(
                      'About',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () => Get.to(() => MyAbout()),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 30,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     const Icon(Icons.help_center_outlined),
              //     const SizedBox(
              //       width: 15,
              //     ),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     GestureDetector(
              //       child: const Text(
              //         'Contact us',
              //         style: TextStyle(fontSize: 20),
              //       ),
              //       onTap: () {
              //         ElevatedButton(
              //             onPressed: () {
              //               launchUrl(Uri(scheme: 'mailto:ajeeshrko@gmail.com'));
              //             },
              //             child: const Text('Send mail'));
              //       },
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(Icons.restart_alt_rounded),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: const Text(
                      'Reset',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Warning"),
                          content: const Text("Do you want to reset the app?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Get.offAll(() => MyIntro());
                              },
                              child: GestureDetector(
                                child: const Text("Yes"),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: GestureDetector(
                                child: const Text("No"),
                              ),
                            )
                          ],
                        ),
                      );
                      final categoryDB = await Hive.openBox<CategoryModel>(
                          'category-database');
                      categoryDB.clear();
                      final transactionDB =
                          await Hive.openBox<TransactionModel>(
                              'transaction_db');
                      transactionDB.clear();
                      // await Hive.openBox("transaction_db");
                      // Hive.box('transaction_db').clear;
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.share_outlined),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: const Text(
                      'Share',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Share.share(
                          'https://play.google.com/store/apps/details?id=com.');
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.text_snippet_outlined),
                  const SizedBox(
                    width: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    child: const Text(
                      'Terms and conditions',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () => Get.to(() => myTerms()),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.privacy_tip_outlined),
                  const SizedBox(
                    width: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    child: const Text(
                      'Privacy policy',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () => Get.to(() => privacy()),
                  ),
                ],
              ),
              const SizedBox(
                height: 300,
              ),
              const Text(
                'v.1.0.1',
                style: TextStyle(fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );
  }
}
