import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

import '../pages/box.dart';

class MyAbout extends StatefulWidget {
  const MyAbout({super.key});

  @override
  State<MyAbout> createState() => _MyStatsState();
}

class _MyStatsState extends State<MyAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: const Text('About'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/87395.jpg'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              const SizedBox(
                height: 85,
              ),
              Box(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      'BUDGET TRACKER',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '"This is an app where you can add your daily transactions according to the category which it belongs to."',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text('Developed by'),
                        Text(
                          'AJEESH DAS.H',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text('Contact Me'),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () async {
                              launchUr(Uri.parse(
                                  'https://instagram.com/ajeesh_aj_abi?igshid=YmMyMTA2M2Y='));
                            },
                            icon: const Icon(FontAwesomeIcons.instagram)),
                        IconButton(
                            onPressed: () async {
                              launchUr(Uri.parse(
                                  'https://www.linkedin.com/in/ajeesh-das-h-601938128/'));
                            },
                            icon: const Icon(FontAwesomeIcons.linkedin)),
                        IconButton(
                            onPressed: () async {
                              launchUr(
                                  Uri.parse('https://github.com/ajeesh1989'));
                            },
                            icon: const Icon(FontAwesomeIcons.github)),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchUr(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch ';
    }
  }
}
