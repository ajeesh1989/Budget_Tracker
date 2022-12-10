import 'package:budget_app/category%20pages/category.dart';
import 'package:budget_app/models/category/category_model.dart';
import 'package:budget_app/pages/graph/graph.dart';
import 'package:budget_app/pages/home/home_page.dart';
import 'package:budget_app/pages/settings.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../db/transaction_db.dart';

double currentBalance = 0.0;
double totalIncome = 0.0;
double totalExpense = 0.0;

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final List<Widget> _pages = [
    const HomePage(),
    const Mycategory(),
    const Graphs(),
    const MySettings(),
  ];

  @override
  void initState() {
    getBalance();
    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    getBalance();
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        color: Colors.grey.shade500,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          Icon(Icons.home),
          Icon(Icons.category),
          Icon(Icons.show_chart_rounded),
          Icon(Icons.settings),
        ],
      ),
    );
  }

  void getBalance() async {
    currentBalance = 0.0;
    totalIncome = 0.0;
    totalExpense = 0.0;
    for (var element in alltransationNotifier.value) {
      if (element.type == CategoryType.income) {
        setState(() {
          currentBalance = currentBalance + element.amount;
          totalIncome = totalIncome + element.amount;
        });
      } else {
        setState(() {
          currentBalance = currentBalance - element.amount;
          totalExpense = totalExpense + element.amount;
        });
      }
    }
  }
}
