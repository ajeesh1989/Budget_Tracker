import 'package:flutter/material.dart';

class MyHelp extends StatefulWidget {
  const MyHelp({super.key});

  @override
  State<MyHelp> createState() => _MyStatsState();
}

class _MyStatsState extends State<MyHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text('Help'),
        centerTitle: true,
      ),
    );
  }
}
