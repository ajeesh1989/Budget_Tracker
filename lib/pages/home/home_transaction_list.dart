import 'dart:developer';
import 'package:budget_app/db/transaction_db.dart';
import 'package:budget_app/models/category/category_model.dart';
import 'package:budget_app/transactions/update_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../models/transaction/transaction_model.dart';

// ignore: must_be_immutable
class HomeTransactionListWidget extends StatefulWidget {
  HomeTransactionListWidget({Key? key, required this.result}) : super(key: key);
  List<TransactionModel> result = [];

  @override
  State<HomeTransactionListWidget> createState() =>
      _HomeTransactionListWidgetState();
}

class _HomeTransactionListWidgetState extends State<HomeTransactionListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: alltransationNotifier,
            builder: (BuildContext ctx, List<TransactionModel> data, _) {
              return widget.result.isEmpty
                  ? const Center(
                      child: Text(
                        'No data',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (ctx, index) {
                        log(widget.result[index].type.toString());
                        final data = widget.result[index];
                        return Slidable(
                          startActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  backgroundColor: Colors.green.shade300,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                  onPressed: ((context) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => UpdateTrans(
                                                  index: index,
                                                  transactionModel: data,
                                                )));
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
                                  }),
                                )
                              ]),
                          child: ListTile(
                            title: Text(widget.result[index].category.name),
                            subtitle:
                                Text(parseDate(widget.result[index].calender)),
                            trailing: Text(
                                '₹ ${widget.result[index].amount.toString()}'),
                            leading:
                                widget.result[index].type == CategoryType.income
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
                      itemCount: widget.result.length,
                    );
            },
          ),
        ),
      ],
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}
