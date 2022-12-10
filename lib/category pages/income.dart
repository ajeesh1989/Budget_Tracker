import 'package:budget_app/db/category_db.dart';
import 'package:budget_app/models/category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';

import 'package:google_fonts/google_fonts.dart';

import 'category_edit.dart';

class ScreenIncome extends StatefulWidget {
  const ScreenIncome({super.key});

  @override
  State<ScreenIncome> createState() => _ScreenIncomeState();
}

class _ScreenIncomeState extends State<ScreenIncome> {
  List update = ['Edit', 'Delete'];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
        valueListenable: CategoryDbFunction.instance.incomeCategoryNotifier,
        builder: (BuildContext ctx, List<CategoryModel> incomeCategoryList,
            Widget? _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomCard(
                width: width,
                height: height * 0.6,
                borderRadius: 20,
                elevation: 0,
                // color: const Color.fromARGB(222, 206, 205, 205),
                child: incomeCategoryList.isEmpty
                    ? Stack(
                        children: [
                          Center(
                            child: Text(
                              'No Income Categories Available',
                              style: GoogleFonts.actor(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 50,
                              crossAxisSpacing: 20,
                            ),
                            itemBuilder: (ctx, index) {
                              final categoryData = incomeCategoryList[index];
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 0.5)),
                                // color: Colors.amber,
                                child: ListTile(
                                  leading: Text(
                                    categoryData.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  trailing: PopupMenuButton(
                                    child: const Icon(
                                      Icons.more_vert,
                                      size: 21,
                                      color: Colors.black,
                                    ),
                                    onSelected: (value) {
                                      if (value == 0) {
                                        editCategoryAddPopup(
                                          context,
                                          categoryMode: CategoryModel(
                                              name: incomeCategoryList[index]
                                                  .name,
                                              type: CategoryType.income),
                                          index: index,
                                        );

                                        //navigater for update screen
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text(
                                                "Do you want to delete this category?"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () async {
                                                  await CategoryDbFunction
                                                      .instance
                                                      .deleteCategory(id: index)
                                                      .then((value) {
                                                    CategoryDbFunction.instance
                                                        .refreshUI();
                                                  });
                                                  setState(() {});
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: const Text("Yes"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: const Text("No"),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return List.generate(2, (index) {
                                        return PopupMenuItem(
                                          value: index,
                                          child: Text(update[index]),
                                        );
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                            itemCount: incomeCategoryList.length),
                      ),
              ),
            ),
          );
        });
  }
}
