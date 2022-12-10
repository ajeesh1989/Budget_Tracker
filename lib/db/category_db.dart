// ignore_for_file: constant_identifier_names

import 'package:budget_app/models/category/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

const CATEGORY_DB_NAME = 'category-database';

bool isFilterEnabled = false;

ValueNotifier<List<int>> ha = ValueNotifier([]);

class CategoryDbFunction {
  ValueNotifier<List<CategoryModel>> incomeCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryNotifier =
      ValueNotifier([]);
  CategoryDbFunction._internal();
  static CategoryDbFunction instance = CategoryDbFunction._internal();
  factory CategoryDbFunction() {
    return instance;
  }
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);

    var id = await categoryDB.add(value);
    // value.id = id.toString();
    refreshUI();
  }

  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategory = await getCategories();
    incomeCategoryNotifier.value.clear();
    expenseCategoryNotifier.value.clear();
    await Future.forEach(allCategory, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryNotifier.value.add(category);
      } else {
        expenseCategoryNotifier.value.add(category);
      }
    });

    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    incomeCategoryNotifier.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    expenseCategoryNotifier.notifyListeners();
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
}
