import 'package:budget_app/models/category/category_model.dart';
import 'package:budget_app/models/transaction/transaction_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:month_year_picker/month_year_picker.dart';

class HomeController extends GetxController {
  final TRANSACTION_DB_NAME = 'transaction_db';

  bool isFilterEnabled = false;
  List<TransactionModel> incometransationNotifier = [];
  List<TransactionModel> expensetransationNotifier = [];

  List<TransactionModel> alltransationNotifier = [];

  late DateTime startDate;
  late DateTime endDate;
  bool isFilterEnable = false;
  late List<TransactionModel> filterList;
  late List<TransactionModel> list;

  Future<void> insertTransaction(TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    await transactionDB.put(value.id, value);
    // value.id = id.toString();

    refreshUI();
  }

  Future<List<TransactionModel>> getTransactions() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return transactionDB.values.toList();
  }

  Future<void> refreshUI() async {
    final alltransaction = await getTransactions();
    incometransationNotifier.clear();
    expensetransationNotifier.clear();

    await Future.forEach(alltransaction, (TransactionModel transaction) {
      if (transaction.type == CategoryType.income) {
        incometransationNotifier.add(transaction);
        update();
      } else if (transaction.type == CategoryType.expense) {
        expensetransationNotifier.add(transaction);
        update();
      }
    });
    alltransationNotifier.clear();

    alltransationNotifier.addAll(alltransaction);
    update();
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
    alltransationNotifier.clear();
    incometransationNotifier.clear();
    expensetransationNotifier.clear();
    alltransationNotifier.addAll(filterList);
    incometransationNotifier.addAll(filterList);
    expensetransationNotifier.addAll(filterList);
    update();
  }

  Future deleteTransaction({required id}) async {
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
