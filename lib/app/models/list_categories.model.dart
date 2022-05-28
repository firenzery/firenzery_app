import 'package:firenzery/app/models/category.model.dart';
import 'package:flutter/material.dart';

class ListCategoriesModel extends ChangeNotifier {
  List<CategoryModel> _categories = [];

  List<CategoryModel> categories() => _categories;

  ListProductsModel() {
    addProductsInList([]);
  }

  //function to check login
  addProductsInList(List<CategoryModel> categories) {
    _categories = categories;
    notifyListeners();
  }
}
