import 'package:budget_app/category%20pages/expence.dart';
import 'package:budget_app/category%20pages/expence_pop.dart';
import 'package:budget_app/category%20pages/income.dart';
import 'package:budget_app/db/category_db.dart';
import 'package:flutter/material.dart';

import '../models/category/category_model.dart';

class Mycategory extends StatefulWidget {
  const Mycategory({super.key});

  @override
  State<Mycategory> createState() => _CatalogueState();
}

class _CatalogueState extends State<Mycategory> with TickerProviderStateMixin {
  late TabController tabController;
  String category = 'Enter Income Category';
  int sel = 1;
  late ValueNotifier<CategoryType> selectedCategoryNotifier;

  List<CategoryModel> h = [];
  @override
  void initState() {
    selectedCategoryNotifier = ValueNotifier(CategoryType.income);
    tabController = TabController(length: 2, vsync: this);
    CategoryDbFunction.instance.refreshUI();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.grey.shade500,
        title: const Text(
          'Add Category',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          color: const Color.fromARGB(255, 248, 248, 248),
          child: Column(children: [
            TabBar(
              labelColor: const Color.fromARGB(255, 6, 6, 6),
              indicatorColor: Colors.grey.shade700,
              unselectedLabelColor: Colors.black,
              controller: tabController,
              onTap: (value) {
                setState(() {
                  if (value == 0) {
                    selectedCategoryNotifier =
                        ValueNotifier(CategoryType.income);
                    category = 'Enter Income Category';
                  } else {
                    selectedCategoryNotifier =
                        ValueNotifier(CategoryType.expense);
                    category = 'Enter Expense Category';
                  }
                });
              },
              tabs: const [
                Tab(
                  text: "I N C O M E",
                ),
                Tab(
                  text: "E X P E N S E",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: const [
                ScreenIncome(),
                ScreenExpence(),
              ]),
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          if (tabController.index == 0) {
            showCategoryAddPopup(context, CategoryType.income);
          } else {
            showCategoryAddPopup(context, CategoryType.expense);
          }
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<CategoryType>(
          value: type,
          groupValue: CategoryType.income,
          onChanged: (value) {},
        ),
        Text(title),
      ],
    );
  }
}
