// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:budget_app/models/category/category_model.dart';
import 'package:budget_app/models/transaction/transaction_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:month_year_picker/month_year_picker.dart';

const TRANSACTION_DB_NAME = 'transaction_db';

bool isFilterEnabled = false;
ValueNotifier<List<TransactionModel>> incometransationNotifier =
    ValueNotifier([]);
ValueNotifier<List<TransactionModel>> expensetransationNotifier =
    ValueNotifier([]);
ValueNotifier<List<TransactionModel>> alltransationNotifier = ValueNotifier([]);

class TransationDbFunction {
  late DateTime startDate;
  late DateTime endDate;
  bool isFilterEnable = false;
  late List<TransactionModel> filterList;
  late List<TransactionModel> list;
  TransationDbFunction._internal();
  static TransationDbFunction instance = TransationDbFunction._internal();
  factory TransationDbFunction() {
    return instance;
  }

  Future<void> insertTransaction(TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    await transactionDB.put(value.id, value);
    // value.id = id.toString();
    log(transactionDB.values.toString());

    refreshUI();
  }

  Future<List<TransactionModel>> getTransactions() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return transactionDB.values.toList();
  }

  Future<void> refreshUI() async {
    final alltransaction = await getTransactions();
    incometransationNotifier.value.clear();
    expensetransationNotifier.value.clear();

    await Future.forEach(alltransaction, (TransactionModel transaction) {
      if (transaction.type == CategoryType.income) {
        incometransationNotifier.value.add(transaction);
      } else if (transaction.type == CategoryType.expense) {
        expensetransationNotifier.value.add(transaction);
      }

      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      incometransationNotifier.notifyListeners();
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      expensetransationNotifier.notifyListeners();
    });
    alltransationNotifier.value.clear();

    alltransationNotifier.value.addAll(alltransaction);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    incometransationNotifier.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    expensetransationNotifier.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    alltransationNotifier.notifyListeners();
  }

  Future<void> refresh() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    list = transactionDB.values.toList();
    if (isFilterEnable) {
      filterList = list
          .where((element) =>
              (element.calender.isAfter(startDate) ||
                  element.calender == startDate) &&
              element.calender.isBefore(endDate))
          .toList();
    } else {
      filterList = list;
    }
    filterList
        .sort((first, second) => second.calender.compareTo(first.calender));
    alltransationNotifier.value.clear();
    incometransationNotifier.value.clear();
    expensetransationNotifier.value.clear();
    alltransationNotifier.value.addAll(filterList);
    incometransationNotifier.value.addAll(filterList);
    expensetransationNotifier.value.addAll(filterList);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    alltransationNotifier.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    incometransationNotifier.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    expensetransationNotifier.notifyListeners();
  }

  Future deleteTransaction({required id}) async {
    log(id);
    final categoryDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await categoryDB.delete(id);
    refreshUI();
  }

  Future updateTransaction(int id, TransactionModel value) async {
    final categoryDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    categoryDB.putAt(id, value);
    refreshUI();
  }

  setFilter(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    isFilterEnable = true;
    refresh();
  }

  clearFilter() {
    isFilterEnable = false;
    refresh();
  }

  DateTime selectedmonth = DateTime.now();

  transactionPickDate(context) async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: selectedmonth,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );

    selectedmonth = selected!;
    DateTime start = DateTime(selectedmonth.year, selectedmonth.month, 1);
    DateTime end = DateTime(start.year, start.month + 1, start.day);
    setFilter(start, end);
  }
}
