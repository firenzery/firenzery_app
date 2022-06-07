import 'package:firenzery/app/interfaces/categories.interface.dart';
import 'package:firenzery/app/models/category.model.dart';
import 'package:firenzery/app/services/remote/categories.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class CategoriesViewModel extends ChangeNotifier {
  ICategories service = CategoriesService(ClientHttpSevice());

  List<CategoryModel> categories = [];

  getAllCategories() async {
    try {
      var response = await service.getAllCategories();

      List categoriesBody = convert.jsonDecode(response.body);

      categories =
          categoriesBody.map((data) => CategoryModel.fromJson(data)).toList();

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
