import 'package:budget_app/db/transaction_db.dart';
import 'package:budget_app/models/category/category_model.dart';
import 'package:budget_app/models/transaction/transaction_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class filterationController extends GetxController {
  List<TransactionModel> overviewNotifier = [];
  List<TransactionModel> incomeNotifier = [];

  List<TransactionModel> expenseNotifier = [];

  List<TransactionModel> todayNotifier = [];

  List<TransactionModel> yesterdayNotifier = [];

  List<TransactionModel> incomeTodayNotifier = [];

  List<TransactionModel> incomeYesterdayNotifier = [];

  List<TransactionModel> expenseTodayNotifier = [];

  List<TransactionModel> expenseYesterdayNotifier = [];

  List<TransactionModel> lastWeekNotifier = [];

  List<TransactionModel> incomeLastWeekNotifier = [];

  List<TransactionModel> expenseLastWeekNotifier = [];

  List<TransactionModel> lastMonthNotifier = [];

  List<TransactionModel> incomeLastMonthNotifier = [];

  List<TransactionModel> expenseLastMonthNotifier = [];

  String today = DateFormat.yMd().format(
    DateTime.now(),
  );
  String yesterday = DateFormat.yMd().format(
    DateTime.now().subtract(
      const Duration(days: 1),
    ),
  );

  filterFunction() async {
    final list = await TransationDbFunction.instance.getTransactions();

    overviewNotifier.clear();
    incomeNotifier.clear();
    expenseNotifier.clear();
    todayNotifier.clear();
    yesterdayNotifier.clear();
    incomeTodayNotifier.clear();
    incomeYesterdayNotifier.clear();
    expenseTodayNotifier.clear();
    expenseYesterdayNotifier.clear();
    lastWeekNotifier.clear();
    expenseLastWeekNotifier.clear();
    incomeLastWeekNotifier.clear();
    lastMonthNotifier.clear();
    expenseLastMonthNotifier.clear();
    incomeLastMonthNotifier.clear();

    for (var element in list) {
      if (element.type == CategoryType.income) {
        incomeNotifier.add(element);
      } else if (element.type == CategoryType.expense) {
        expenseNotifier.add(element);
      }
      overviewNotifier.add(element);
    }
    // log(incomeNotifier.toString());

    for (var element in list) {
      String elementDate = DateFormat.yMd().format(element.calender);
      if (elementDate == today) {
        todayNotifier.add(element);
      }

      if (elementDate == yesterday) {
        yesterdayNotifier.add(element);
      }
      if (element.calender.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      )) {
        lastWeekNotifier.add(element);
      }

      if (element.calender.isAfter(
        DateTime.now().subtract(
          const Duration(days: 30),
        ),
        // selectedGrapMonth
      )) {
        lastMonthNotifier.add(element);
      }

      if (elementDate == today && element.type == CategoryType.income) {
        incomeTodayNotifier.add(element);
      }

      if (elementDate == yesterday && element.type == CategoryType.income) {
        incomeYesterdayNotifier.add(element);
      }

      if (elementDate == today && element.type == CategoryType.expense) {
        expenseTodayNotifier.add(element);
      }

      if (elementDate == yesterday && element.type == CategoryType.expense) {
        expenseYesterdayNotifier.add(element);
      }
      if (element.calender.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ) &&
          element.type == CategoryType.income) {
        incomeLastWeekNotifier.add(element);
      }

      if (element.calender.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ) &&
          element.type == CategoryType.expense) {
        expenseLastWeekNotifier.add(element);
      }

      if (element.calender.isAfter(
            DateTime.now().subtract(
              const Duration(days: 30),
            ),
          ) &&
          element.type == CategoryType.income) {
        incomeLastMonthNotifier.add(element);
      }

      if (element.calender.isAfter(
            DateTime.now().subtract(
              const Duration(days: 30),
            ),
          ) &&
          element.type == CategoryType.expense) {
        expenseLastMonthNotifier.add(element);
      }
    }
    update();
  }
//  DateTime selectedGrapMonth = DateTime.now();
//   grapPickDate(BuildContext context) async {
//     final selectedMonth = await showMonthYearPicker(
//       context: context,
//       initialDate: selectedGrapMonth,
//       firstDate: DateTime(2021),
//       lastDate: DateTime(2023),
//     );
//     selectedGrapMonth = selectedMonth!;
//     chartLogic(lastMonthNotifier.value);
//   }

}
