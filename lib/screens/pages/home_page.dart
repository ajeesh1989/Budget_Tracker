import 'package:budget_app/controller/home_controller.dart';
import 'package:budget_app/db/category_db.dart';
import 'package:budget_app/db/transaction_db.dart';
import 'package:budget_app/screens/pages/box.dart';
import 'package:budget_app/screens/pages/search.dart';
import 'package:budget_app/transactions/recent_transactions.dart';
import 'package:budget_app/transactions/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_generator/hive_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../transactions/my_transactions.dart';
import '../../../widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String username = '';

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  final homeController = Get.put(HomeController());

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    autoLogIn();
    CategoryDbFunction.instance.refreshUI();
    incometransationNotifier.value;
    expensetransationNotifier.value;
    alltransationNotifier.value;
    CategoryDbFunction.instance.expenseCategoryNotifier.value;
    CategoryDbFunction.instance.incomeCategoryNotifier.value;
    super.initState();
  }

  void autoLogIn() async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('nameKey').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: SizedBox(
              width: 260,
              child: IconButton(
                icon:
                    Image.asset('lib/images/Screenshot 2022-11-11 231101.png'),
                onPressed: () {},
              ),
            ),
          ),
          Box(
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () => showSearch(
                context: context,
                delegate: CustomSerchDelegate(),
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        const Text(
                          'H O M E',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text(
                                'Hi',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                username,
                                style: const TextStyle(
                                    fontSize: 21, color: Colors.black),
                              ),
                              const Text(','),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: incometransationNotifier,
                  builder: (BuildContext context, value, Widget? _) => Box(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'C U R R E N T   B A L A N C E',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Text(
                          '₹ $currentBalance',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Income',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 42, 114, 46),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        Icons.arrow_upward,
                                        color: Colors.green.shade800,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    '₹ $totalIncome',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_downward,
                                        color: Colors.red.shade800,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        'Expense',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 163, 34, 34),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    '₹ $totalExpense',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'RECENT TRANSACTIONS',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    GestureDetector(
                      child: const SizedBox(
                        height: 40,
                        width: 105,
                        child: Center(
                          child: Box(
                            child: Text(
                              'VIEW ALL',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                      onTap: () => Get.to(() => MyTansactions()),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(child: recent()),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(() => AddTransactionScreen());
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
