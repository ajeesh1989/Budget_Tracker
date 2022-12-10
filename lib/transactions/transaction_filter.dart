import 'package:budget_app/db/transaction_db.dart';
import 'package:budget_app/models/transaction/transaction_model.dart';
import 'package:budget_app/pages/home/home_transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ViewAllTransation extends StatefulWidget {
  const ViewAllTransation({super.key});
  @override
  State<ViewAllTransation> createState() => _ViewAllTransationState();
}

class _ViewAllTransationState extends State<ViewAllTransation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    results = alltransationNotifier.value;

    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      final DateTime now = DateTime.now();
      setState(() {
        if (dropDownVale == 'All') {
          setState(() {
            results = (_tabController.index == 0
                ? alltransationNotifier.value.toList()
                : _tabController.index == 1
                    ? incometransationNotifier.value.toList()
                    : expensetransationNotifier.value.toList());
          });
        } else if (dropDownVale == 'today') {
          setState(() {
            results = (_tabController.index == 0
                    ? alltransationNotifier.value.toList()
                    : _tabController.index == 1
                        ? incometransationNotifier.value.toList()
                        : expensetransationNotifier.value.toList())
                .where((element) => parseDate(element.calender)
                    .toLowerCase()
                    .contains(parseDate(DateTime.now()).toLowerCase()))
                .toList();
          });
        } else if (dropDownVale == 'yesterday') {
          setState(() {
            DateTime start = DateTime(now.year, now.month, now.day - 1);
            DateTime end = start.add(const Duration(days: 1));
            results = (_tabController.index == 0
                    ? alltransationNotifier.value
                    : _tabController.index == 1
                        ? incometransationNotifier.value
                        : expensetransationNotifier.value)
                .where((element) =>
                    (element.calender.isAfter(start) ||
                        element.calender == start) &&
                    element.calender.isBefore(end))
                .toList();
          });
        } else if (dropDownVale == 'week') {
          setState(() {
            DateTime start = DateTime(now.year, now.month, now.day - 6);
            DateTime end = DateTime(start.year, start.month, start.day + 7);
            results = (_tabController.index == 0
                    ? alltransationNotifier.value
                    : _tabController.index == 1
                        ? incometransationNotifier.value
                        : expensetransationNotifier.value)
                .where((element) =>
                    (element.calender.isAfter(start) ||
                        element.calender == start) &&
                    element.calender.isBefore(end))
                .toList();
          });
        } else {
          setState(() {
            DateTime start =
                DateTime(selectedmonth.year, selectedmonth.month, 1);
            DateTime end = DateTime(start.year, start.month + 1, start.day);
            results = (_tabController.index == 0
                    ? alltransationNotifier.value
                    : _tabController.index == 1
                        ? incometransationNotifier.value
                        : expensetransationNotifier.value)
                .where((element) =>
                    (element.calender.isAfter(start) ||
                        element.calender == start) &&
                    element.calender.isBefore(end))
                .toList();
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  DateTime selectedmonth = DateTime.now();
  void _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary:
                    Color.fromARGB(213, 20, 27, 38), // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Color.fromARGB(213, 20, 27, 38), // body text color
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedmonth,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));

    if (picked != null && picked != selectedmonth) {
      setState(() {
        selectedmonth = picked;
      });
    }
  }

  dynamic dropDownVale = 'All';

  List items = ['All', 'today', 'yesterday', 'week', 'custom'];

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }

  List<TransactionModel> results = [];
  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      setState(() {
        results = alltransationNotifier.value;
      });
    } else {
      setState(() {
        // log('');
        results = alltransationNotifier.value
            .where((user) => user.category.name
                .toString()
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          //
          body: ValueListenableBuilder(
            valueListenable: alltransationNotifier,
            builder: (context, value, child) => Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 19, right: 19, top: 20, bottom: 1),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 224, 224, 224),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 158, 158, 158),
                              blurRadius: 15,
                              offset: Offset(5, 5),
                            ),
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 15,
                              offset: Offset(-5, -5),
                            ),
                          ]),
                      child: TextField(
                        onChanged: (value) {
                          _runFilter(value);
                        },
                        autofocus: false,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.search),
                            fillColor: const Color.fromARGB(255, 224, 224, 224),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 241, 241, 241),
                                    style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(20.0)),
                            label: const Text('Search'),
                            hintStyle:
                                const TextStyle(fontWeight: FontWeight.w300),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 241, 241, 241)),
                                borderRadius: BorderRadius.circular(20.0)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 241, 241, 241)),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 9.0, horizontal: 10.0)),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 250.0, right: 5),
                  child: DropdownButton(
                      icon: const Icon(Icons.filter_list_alt),
                      underline: Container(),
                      elevation: 0,
                      borderRadius: BorderRadius.circular(10),
                      items: items.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(e),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue == 'custom') {
                          _selectDate(context);
                        }

                        setState(() {
                          dropDownVale = newValue;
                        });
                        final DateTime now = DateTime.now();
                        if (dropDownVale == 'All') {
                          setState(() {
                            results = (_tabController.index == 0
                                ? alltransationNotifier.value.toList()
                                : _tabController.index == 1
                                    ? incometransationNotifier.value.toList()
                                    : expensetransationNotifier.value.toList());
                          });
                        } else if (dropDownVale == 'today') {
                          setState(() {
                            results = (_tabController.index == 0
                                    ? alltransationNotifier.value.toList()
                                    : _tabController.index == 1
                                        ? incometransationNotifier.value
                                            .toList()
                                        : expensetransationNotifier.value
                                            .toList())
                                .where((element) => parseDate(element.calender)
                                    .toLowerCase()
                                    .contains(parseDate(DateTime.now())
                                        .toLowerCase()))
                                .toList();
                          });
                        } else if (dropDownVale == 'yesterday') {
                          setState(() {
                            DateTime start =
                                DateTime(now.year, now.month, now.day - 1);
                            DateTime end = start.add(const Duration(days: 1));
                            results = (_tabController.index == 0
                                    ? alltransationNotifier.value
                                    : _tabController.index == 1
                                        ? incometransationNotifier.value
                                        : expensetransationNotifier.value)
                                .where((element) =>
                                    (element.calender.isAfter(start) ||
                                        element.calender == start) &&
                                    element.calender.isBefore(end))
                                .toList();
                          });
                        } else if (dropDownVale == 'week') {
                          setState(() {
                            DateTime start =
                                DateTime(now.year, now.month, now.day - 6);
                            DateTime end = DateTime(
                                start.year, start.month, start.day + 7);
                            results = (_tabController.index == 0
                                    ? alltransationNotifier.value
                                    : _tabController.index == 1
                                        ? incometransationNotifier.value
                                        : expensetransationNotifier.value)
                                .where((element) =>
                                    (element.calender.isAfter(start) ||
                                        element.calender == start) &&
                                    element.calender.isBefore(end))
                                .toList();
                          });
                        } else {
                          setState(() {
                            DateTime start = DateTime(
                                selectedmonth.year, selectedmonth.month, 1);
                            DateTime end = DateTime(
                                start.year, start.month + 1, start.day);
                            results = (_tabController.index == 0
                                    ? alltransationNotifier.value
                                    : _tabController.index == 1
                                        ? incometransationNotifier.value
                                        : expensetransationNotifier.value)
                                .where((element) =>
                                    (element.calender.isAfter(start) ||
                                        element.calender == start) &&
                                    element.calender.isBefore(end))
                                .toList();
                          });
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade900,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 158, 158, 158),
                            blurRadius: 15,
                            offset: Offset(5, 5),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 15,
                            offset: Offset(-5, -5),
                          ),
                        ]),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'Overview',
                      ),
                      Tab(
                        text: 'Income',
                      ),
                      Tab(
                        text: 'Expense',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: TabBarView(controller: _tabController, children: [
                  HomeTransactionListWidget(result: results),
                  HomeTransactionListWidget(
                    result: results,
                  ),
                  HomeTransactionListWidget(
                    result: results,
                  )
                ])),
              ],
            ),
          ),
        ));
  }

  setFilter(var selction) async {
    final DateTime now = DateTime.now();
    switch (selction) {
      case 'All':
        TransationDbFunction.instance.clearFilter();
        break;
      case 'Today':
        DateTime start = DateTime(now.year, now.month, now.day);
        DateTime end = start.add(const Duration(days: 1));
        TransationDbFunction.instance.setFilter(start, end);
        break;
      case 'Yesterday':
        DateTime start = DateTime(now.year, now.month, now.day - 1);
        DateTime end = start.add(const Duration(days: 1));
        TransationDbFunction.instance.setFilter(start, end);
        break;
      case 'Week':
        DateTime start = DateTime(now.year, now.month, now.day - 6);
        DateTime end = DateTime(start.year, start.month, start.day + 7);
        TransationDbFunction.instance.setFilter(start, end);
        break;
      case 'Month':
        TransationDbFunction.instance.transactionPickDate(context);
        break;

      default:
        break;
    }
  }
}
