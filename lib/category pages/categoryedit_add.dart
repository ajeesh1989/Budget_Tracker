import 'package:budget_app/models/category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../db/category_db.dart';

class AddCateoryDialog extends StatefulWidget {
  const AddCateoryDialog({
    Key? key,
    this.category,
    required this.type,
    required this.index,
  }) : super(key: key);
  final CategoryType type;
  final CategoryModel? category;
  final int index;

  @override
  State<AddCateoryDialog> createState() => _AddCateoryDialogState();
}

class _AddCateoryDialogState extends State<AddCateoryDialog> {
  final controller = TextEditingController();
  IconData? icon;
  final CategoryDbFunction _categoryManager = CategoryDbFunction();
  bool isEdit = false;

  String? errorText;
  @override
  void initState() {
    isEdit = widget.category != null;
    if (isEdit) {
      controller.text = widget.category!.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Enter your category',
        textAlign: TextAlign.center,
      ),
      titleTextStyle: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(fontWeight: FontWeight.bold),
      elevation: 1,
      content: TextFormField(
        controller: controller,
        onChanged: (name) {
          if (errorText != null) showError(null);
        },
        autofocus: true,
        maxLength: 15,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (name) {
          save();
        },
        decoration: InputDecoration(
            hintText: 'Category Name',
            counterText: '',
            errorText: errorText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8)),
      ),
      actions: [_cancelButton(context), _okButton(context)],
    );
  }

  _okButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          save();
        },
        child: const Text('OK'));
  }

  _cancelButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('Cancel'));
  }

  save() {
    final String catName = controller.text;
    if (catName.isEmpty) {
      showError("Name can't be empty");
      return;
    }
    if (!isEdit) {
      showError('Category already exist');
      return;
    }
    CategoryModel category = CategoryModel(name: catName, type: widget.type);
    if (isEdit) {
      _categoryManager.updateCategory(widget.index, category);
    } else {
      _categoryManager.insertCategory(category);
    }
    Get.back();
  }

  showError(String? string) {
    setState(() {
      errorText = string;
    });
  }
}
