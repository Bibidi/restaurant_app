import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/helpers/category.dart';
import 'package:restaurant_app/models/category.dart';

class CategoryProvider with ChangeNotifier {
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];
  List<String> categoryNames = [];
  String selectedCategory;

  CategoryProvider.initialize() {
    loadCategories();
  }

  loadCategories() async {
    categories = await _categoryServices.getCategories();
    for (CategoryModel category in categories) {
      categoryNames.add(category.name);
    }
    selectedCategory = categoryNames[0];
    notifyListeners();
  }

  changeSelectedCategory({String newCategory}) {
    selectedCategory = newCategory;
    notifyListeners();
  }
}