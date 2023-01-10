import 'dart:developer';

import 'package:budget_app/controller/home_controller.dart';
import 'package:budget_app/db/transaction_db.dart';
import 'package:budget_app/transactions/update_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/category/category_model.dart';
import '../models/transaction/transaction_model.dart';

// ignore: camel_case_types
class recent extends StatelessWidget {
  recent({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await TransationDbFunction.instance.refreshUI();
    });
    return Scaffold(
        body: GetBuilder<HomeController>(
      builder: (controller) => homeController.alltransationNotifier.isEmpty
          ? const Center(
              child: Text(
                'No data',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                final data = homeController.alltransationNotifier[index];
                return Slidable(
                  startActionPane:
                      ActionPane(motion: const StretchMotion(), children: [
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
                                "Do you want to delete this transaction?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  await TransationDbFunction()
                                      .deleteTransaction(
                                          id: homeController
                                              .alltransationNotifier[index].id);

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
                  child: ListTile(
                    title: Text(data.category.name),
                    subtitle: Text(parseDate(data.calender)),
                    trailing: Text('₹ ${data.amount.toString()}'),
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
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemCount: homeController.alltransationNotifier.length >= 4
                  ? 4
                  : homeController.alltransationNotifier.length,
            ),
    ));
  }

  String parseDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}
