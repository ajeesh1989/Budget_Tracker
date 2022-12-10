// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class Graphs extends StatefulWidget {
//   const Graphs({Key? key}) : super(key: key);

//   @override
//   State<Graphs> createState() => _GraphsState();
// }

// class _GraphsState extends State<Graphs> with TickerProviderStateMixin {
//   // List<ChartDatas> dataExpense = chartLogic(expenseNotifier.value);
//   // List<ChartDatas> dataIncome = chartLogic(incomeNotifier.value);
//   // List<ChartDatas> overview = chartLogic(overviewNotifier.value);
//   // List<ChartDatas> yesterday = chartLogic(yesterdayNotifier.value);
//   // List<ChartDatas> today = chartLogic(todayNotifier.value);
//   // List<ChartDatas> month = chartLogic(lastMonthNotifier.value);
//   // List<ChartDatas> week = chartLogic(lastWeekNotifier.value);
//   // List<ChartDatas> todayIncome = chartLogic(incomeTodayNotifier.value);
//   // List<ChartDatas> incomeYesterday = chartLogic(incomeYesterdayNotifier.value);
//   // List<ChartDatas> incomeweek = chartLogic(incomeLastWeekNotifier.value);
//   // List<ChartDatas> incomemonth = chartLogic(incomeLastMonthNotifier.value);
//   // List<ChartDatas> todayExpense = chartLogic(expenseTodayNotifier.value);
//   // List<ChartDatas> expenseYesterday =
//   //     chartLogic(expenseYesterdayNotifier.value);
//   // List<ChartDatas> expenseweek = chartLogic(expenseLastWeekNotifier.value);
//   // List<ChartDatas> expensemonth = chartLogic(expenseLastMonthNotifier.value);
//   late TabController tabController;

//   @override
//   void initState() {
//     tabController = TabController(length: 3, vsync: this);
//     // filterFunction();
//     chartdivertFunctionExpense();
//     chartdivertFunctionIncome();
//     super.initState();
//   }

//   String categoryId2 = 'All';
//   int touchIndex = 1;

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.grey.shade500,
//         title: const Text(
//           'Statistics',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Lottie.network(
//                 'https://assets1.lottiefiles.com/packages/lf20_pz4xjiod.json',
//                 width: width * 0.9,
//                 height: height * 0.8),
//           ],
//         ),
//       ),
//     );
//     //  const Padding(
//     //       padding: const EdgeInsets.all(
//     //         16,
//     //       ),
//     //       child:
//     //           // chartdivertFunctionExpense().isEmpty
//     //           Center(
//     //         child: Lottie.asset(
//     //           'lib/assets/image/lotties/89237-graph.json',
//     //           width: width * 0.9,
//     //           height: height * 0.4,
//     //         ),
//     //       )
//     //       // : SfCircularChart(
//     //       //     legend: Legend(
//     //       //       isVisible: true,
//     //       //       overflowMode: LegendItemOverflowMode.wrap,
//     //       //       position: LegendPosition.bottom,
//     //       //     ),
//     //       //     series: <CircularSeries>[
//     //       //       PieSeries<ChartDatas, String>(
//     //       //         dataLabelSettings: const DataLabelSettings(
//     //       //           isVisible: true,
//     //       //           connectorLineSettings:
//     //       //               ConnectorLineSettings(type: ConnectorType.curve),
//     //       //           overflowMode: OverflowMode.shift,
//     //       //           showZeroValue: false,
//     //       //           labelPosition: ChartDataLabelPosition.outside,
//     //       //         ),
//     //       //         dataSource: chartdivertFunctionExpense(),
//     //       //         xValueMapper: (ChartDatas data, _) => data.category,
//     //       //         yValueMapper: (ChartDatas data, _) => data.amount,
//     //       //         explode: true,
//     //       //       )
//     //       );
//   }

//   chartdivertFunctionOverview() {
//     // if (categoryId2 == 'All') {
//     //   return overview;
//     // }
//     // if (categoryId2 == 'Today') {
//     //   return today;
//     // }
//     // if (categoryId2 == 'Yesterday') {
//     //   return yesterday;
//     // }
//     // if (categoryId2 == 'This week') {
//     //   return week;
//     // }
//     // if (categoryId2 == 'month') {
//     //   return month;
//     // }
//   }

//   chartdivertFunctionIncome() {
//     // if (categoryId2 == 'All') {
//     //   return dataIncome;
//     // }
//     // if (categoryId2 == 'Today') {
//     //   return todayIncome;
//     // }
//     // if (categoryId2 == 'Yesterday') {
//     //   return incomeYesterday;
//     // }
//     // if (categoryId2 == 'This week') {
//     //   return incomeweek;
//     // }
//     // if (categoryId2 == 'month') {
//     //   return incomemonth;
//     // }
//   }

//   chartdivertFunctionExpense() {
//     // if (categoryId2 == 'All') {
//     //   return dataExpense;
//     // }
//     // if (categoryId2 == 'Today') {
//     //   return todayExpense;
//     // }
//     // if (categoryId2 == 'Yesterday') {
//     //   return expenseYesterday;
//     // }
//     // if (categoryId2 == 'This week') {
//     //   return expenseweek;
//     // }
//     // if (categoryId2 == 'month') {
//     //   return expensemonth;
//     // }
//   }
// }
