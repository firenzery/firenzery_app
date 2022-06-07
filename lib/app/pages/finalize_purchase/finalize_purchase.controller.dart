import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/models/sale.model.dart';
import 'package:firenzery/app/viewmodels/sale.viewmodel.dart';
import 'package:flutter/material.dart';

enum FinalizePurchaseState { idle, loading, success, error }

class FinalizePurchaseController extends ChangeNotifier {
  FinalizePurchaseState state = FinalizePurchaseState.idle;

  addSaleByUser(SaleViewModel saleViewModel, SaleModel sale,
      List<ProductModel> products) async {
    try {
      state = FinalizePurchaseState.loading;
      notifyListeners();

      await saleViewModel.addSaleByUser(sale, products);

      state = FinalizePurchaseState.success;
      notifyListeners();
    } catch (error) {
      state = FinalizePurchaseState.error;
    }
  }
}
