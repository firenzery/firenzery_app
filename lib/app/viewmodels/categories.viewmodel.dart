import 'package:firenzery/app/interfaces/categories.interface.dart';
import 'package:firenzery/app/models/category.model.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class CategoriesViewModel {
  ICategories service;

  CategoriesViewModel(this.service);

  ValueNotifier<CategoryModel> model = ValueNotifier<CategoryModel>(
      CategoryModel(icon: null, title: null, type: null));

  getAllCategories() async {
    try {
      var response = await service.getAllCategories();

      List categories = convert.jsonDecode(response.body);

      categories =
          categories.map((data) => CategoryModel.fromJson(data)).toList();

      return categories;
    } catch (error) {
      return error;
    }
  }
}
