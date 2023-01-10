import 'dart:developer';
import 'package:budget_app/controller/home_controller.dart';
import 'package:budget_app/db/transaction_db.dart';
import 'package:budget_app/models/category/category_model.dart';
import 'package:budget_app/transactions/update_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../models/transaction/transaction_model.dart';

// ignore: must_be_immutable
class HomeTransactionListWidget extends StatefulWidget {
  HomeTransactionListWidget({Key? key, required this.result}) : super(key: key);
  List<TransactionModel> result = [];

  @override
  State<HomeTransactionListWidget> createState() =>
      _HomeTransactionListWidgetState();
}

class _HomeTransactionListWidgetState extends State<HomeTransactionListWidget> {
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        children: [
          Expanded(
            child: homeController.alltransationNotifier.isEmpty
                ? const Center(
                    child: Text(
                      'No data',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (ctx, index) {
                      log(widget.result[index].type.toString());
                      final transactionValue =
                          homeController.alltransationNotifier[index];
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
                                        transactionModel: transactionValue,
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
                                                .deleteTransaction(
                                                    id: widget
                                                        .result[index].id);

                                            setState(() {});
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
                          title: Text(transactionValue.category.name),
                          subtitle: Text(parseDate(transactionValue.calender)),
                          trailing:
                              Text('₹ ${transactionValue.amount.toString()}'),
                          leading: transactionValue.type == CategoryType.income
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
                    itemCount: homeController.alltransationNotifier.length,
                  ),
          ),
        ],
      ),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}
