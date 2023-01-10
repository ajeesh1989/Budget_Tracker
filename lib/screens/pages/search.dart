import 'package:budget_app/db/transaction_db.dart';
import 'package:budget_app/models/category/category_model.dart';
import 'package:budget_app/models/transaction/transaction_model.dart';
import 'package:budget_app/transactions/update_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CustomSerchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.clear_outlined,
            color: Colors.black,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back_sharp,
          color: Colors.black,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: alltransationNotifier,
      builder: (BuildContext ctx, List<TransactionModel> transactionList,
          Widget? child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: CustomCard(
                elevation: 0,
                color: const Color.fromARGB(255, 216, 212, 212),
                width: width * 0.98,
                height: height * 0.96,
                borderRadius: 20,
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = transactionList[index];
                    if (data.category.name
                        .toLowerCase()
                        .contains(query.toLowerCase())) {
                      return Slidable(
                        startActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.green.shade300,
                                icon: Icons.edit,
                                label: 'Edit',
                                onPressed: ((context) {
                                  Get.to(() => UpdateTrans(
                                        index: index,
                                        transactionModel: data,
                                      ));
                                }),
                              ),
                              SlidableAction(
                                backgroundColor: Colors.red.shade300,
                                icon: Icons.delete,
                                label: 'Delete',
                                onPressed: ((context) {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text(
                                          "Do you want to delete this category?"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () async {
                                            await TransationDbFunction()
                                                .deleteTransaction(id: data.id);

                                            // ignore: use_build_context_synchronously
                                            Get.back();
                                          },
                                          child: const Text("Yes"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("No"),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              )
                            ]),
                        child: Column(
                          children: [
                            CustomCard(
                                borderRadius: 100,
                                child: ListTile(
                                  leading: data.type == CategoryType.expense
                                      ? const Icon(
                                          Icons.arrow_circle_up_outlined,
                                          color: Colors.green,
                                          size: 35,
                                        )
                                      : const Icon(
                                          Icons.arrow_circle_down_outlined,
                                          color: Colors.red,
                                          size: 35,
                                        ),
                                )),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Text('');
                    }
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox();
                  },
                  itemCount: transactionList.length,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: alltransationNotifier,
      builder: (BuildContext ctx, List<TransactionModel> transactiontList,
          Widget? child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: CustomCard(
                elevation: 0,
                color: Colors.white54,
                width: width * 0.98,
                height: height * 0.96,
                borderRadius: 20,
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = transactiontList[index];
                    if (data.category.name
                        .toLowerCase()
                        .contains(query.toLowerCase())) {
                      return Slidable(
                        startActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.green.shade300,
                                icon: Icons.edit,
                                label: 'Edit',
                                onPressed: ((context) {
                                  Get.to(() => UpdateTrans(
                                        index: index,
                                        transactionModel: data,
                                      ));
                                }),
                              ),
                              SlidableAction(
                                backgroundColor: Colors.red.shade300,
                                icon: Icons.delete,
                                label: 'Delete',
                                onPressed: ((context) {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text(
                                          "Do you want to delete this category?"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () async {
                                            await TransationDbFunction()
                                                .deleteTransaction(id: data.id);

                                            // ignore: use_build_context_synchronously
                                            Get.back();
                                          },
                                          child: const Text("Yes"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("No"),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              )
                            ]),
                        child: Column(
                          children: [
                            CustomCard(
                              // borderRadius: 100,
                              child: ListTile(
                                leading: data.type == CategoryType.income
                                    ? const Icon(
                                        Icons.arrow_circle_up_outlined,
                                        color: Colors.green,
                                        size: 35,
                                      )
                                    : const Icon(
                                        Icons.arrow_circle_down_outlined,
                                        color: Colors.red,
                                        size: 35,
                                      ),
                                title: Text(data.category.name),
                                subtitle: Text(
                                  data.type.name,
                                  style: TextStyle(
                                    color: data.type == CategoryType.income
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '₹ ${data.amount.toString()}',
                                        style: TextStyle(
                                          color:
                                              data.type == CategoryType.income
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Text(parseDate(data.date))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Text('');
                    }
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox();
                  },
                  itemCount: transactiontList.length,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
