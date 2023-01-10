import 'package:budget_app/models/category/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class categoryController extends GetxController {
  final CATEGORY_DB_NAME = 'category-database';

  bool isFilterEnabled = false;

  List<int> ha = [];

  List<CategoryModel> incomeCategoryNotifier = [];
  List<CategoryModel> expenseCategoryNotifier = [];

  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);

    var id = await categoryDB.add(value);
    refreshUI();
  }

  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategory = await getCategories();
    incomeCategoryNotifier.clear();
    expenseCategoryNotifier.clear();
    await Future.forEach(allCategory, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryNotifier.add(category);
      } else {
        expenseCategoryNotifier.add(category);
      }
    });
    update();
  }

  Future deleteCategory({required id}) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.deleteAt(id);
    await refreshUI();
  }

  Future updateCategory(int id, CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.put(id, value);
    refreshUI();
  }

  String category = 'Enter income category';
}
