import 'package:budget_app/db/transaction_db.dart';
import 'package:budget_app/transactions/transaction_filter.dart';
import 'package:flutter/material.dart';

class MyTansactions extends StatefulWidget {
  const MyTansactions({super.key});

  @override
  State<MyTansactions> createState() => _MyTransactionsState();
}

class _MyTransactionsState extends State<MyTansactions> {
  @override
  void initState() {
    super.initState();

    TransationDbFunction.instance.refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade800,
          title: const Text('My Transactions'),
        ),
        body: const ViewAllTransation()
        // const HomeTransactionListWidget(),
        );
  }
}
