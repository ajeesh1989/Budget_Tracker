import 'package:budget_app/category%20pages/expence_pop.dart';
import 'package:budget_app/controller/category_controller.dart';
import 'package:budget_app/controller/home_controller.dart';
import 'package:budget_app/db/category_db.dart';
import 'package:budget_app/db/transaction_db.dart';
import 'package:budget_app/db/filteration_db.dart';
import 'package:budget_app/models/category/category_model.dart';
import 'package:budget_app/models/transaction/transaction_model.dart';
import 'package:budget_app/screens/pages/box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final transactionController = Get.put(HomeController());
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  final categoryc = Get.put(categoryController());
  DateTime? selectedDate;
  CategoryType selectedCategoryType = CategoryType.income;
  CategoryModel? selectedCategoryModel;
  String? categoryID;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    selectedCategoryType = CategoryType.income;

    CategoryDbFunction.instance.incomeCategoryNotifier.value;

    CategoryDbFunction.instance.expenseCategoryNotifier.value;
    CategoryDbFunction.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: const Text(
          'Add Transaction',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.black,
                        value: CategoryType.income,
                        groupValue: selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategoryType = CategoryType.income;
                            categoryID = null;
                          });
                        },
                      ),
                      const Text(
                        'Income',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.black,
                        value: CategoryType.expense,
                        groupValue: selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategoryType = CategoryType.expense;
                            categoryID = null;
                          });
                        },
                      ),
                      const Text('Expense', style: TextStyle(fontSize: 18))
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Box(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton.icon(
                              style: ButtonStyle(
                                alignment: Alignment.centerLeft,
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(340, 50)),
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                final selectedDateTemp = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 30)),
                                  lastDate: DateTime.now(),
                                );
                                if (selectedDateTemp == null) {
                                  return;
                                } else {
                                  setState(() {
                                    selectedDate = selectedDateTemp;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.black,
                              ),
                              label: Text(
                                selectedDate == null
                                    ? 'Select Date'
                                    : parseDate(selectedDate!),
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    showCategoryAddPopup(
                                        context, selectedCategoryType);
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.black,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.category_rounded,
                                  color: Color.fromARGB(255, 131, 128, 128),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                              ),
                              dropdownColor:
                                  const Color.fromARGB(255, 249, 249, 249),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(10),
                              hint: const Text('Select Category'),
                              value: categoryID,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Category Items is Empty';
                                } else {
                                  return null;
                                }
                              },
                              items:
                                  (selectedCategoryType == CategoryType.income
                                          ? CategoryDbFunction
                                              .instance.incomeCategoryNotifier
                                          : CategoryDbFunction
                                              .instance.expenseCategoryNotifier)
                                      .value
                                      .map((e) {
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.name),
                                  onTap: () {
                                    selectedCategoryModel = e;
                                  },
                                );
                              }).toList(),
                              onChanged: (selectValue) {
                                setState(() {
                                  categoryID = selectValue;
                                });
                              }),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Category is Empty';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.currency_rupee,
                                color: Color.fromARGB(255, 99, 96, 96),
                              ),
                              hintText: 'Enter amount',
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade600),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade600),
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Category is Empty';
                              } else {
                                return null;
                              }
                            },
                            controller: _notesController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.notes,
                                color: Color.fromARGB(255, 99, 96, 96),
                              ),
                              hintText: 'Description',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 123, 120, 120)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade600),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await addTransaction();
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    "Transaction saved successfully",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ));
                              } else {
                                return;
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final parsedAmount = int.tryParse(_amountController.value.text);
    if (parsedAmount == null) {
      return;
    }
    if (selectedDate == null) {
      return;
    }

    final description = _notesController.value.text;
    final transaction = TransactionModel(
      category: selectedCategoryModel!,
      amount: parsedAmount,
      calender: selectedDate!,
      description: description,
      type: selectedCategoryType,
    );
    // log(transaction.toString());
    transactionController.insertTransaction(transaction);
    filterFunction();

    Get.back();
    transactionController.alltransationNotifier;
    transactionController.refreshUI();
    categoryc.refreshUI();
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
