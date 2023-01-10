import 'dart:developer';

import 'package:budget_app/db/category_db.dart';
import 'package:budget_app/models/category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> editCategoryAddPopup(
  BuildContext context,
  // ignore: non_constant_identifier_names
  {
  required CategoryModel categoryMode,
  required int index,
}) async {
  final nameController = TextEditingController(text: categoryMode.name);
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Edit your category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: TextFormField(
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Category item is Empty';
                  } else {
                    return null;
                  }
                },
                controller: nameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 231, 229, 229),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  // hintText: 'Category Item',
                ),
              ),
            ),
          ),
          // Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       children: const [
          //         RadioButton(title: 'Income', type: CategoryType.income),
          //         RadioButton(title: 'Expence', type: CategoryType.expense),
          //       ],
          //     )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                final name = nameController.text.trim();
                if (formKey.currentState!.validate()) {
                  // final type = selectedCategoryNotifier.value;
                  final category = CategoryModel(
                    // id: DateTime.now().microsecondsSinceEpoch.toString(),
                    name: name,
                    type: categoryMode.type,
                  );
                  log(category.toString());
                  CategoryDbFunction.instance.updateCategory(index, category);
                  CategoryDbFunction.instance.refreshUI();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        "Category updated successfully",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                  Get.back();
                }
              },
              child: const Text(
                'Update',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              activeColor: Colors.black,
              value: type,
              groupValue: selectedCategoryNotifier.value,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                selectedCategoryNotifier.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
