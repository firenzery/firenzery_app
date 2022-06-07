import 'package:firenzery/app/viewmodels/sale.viewmodel.dart';
import 'package:flutter/material.dart';

class RequestDetailController extends ChangeNotifier {
  getProductsBySaleId(SaleViewModel saleViewModel, int saleId) async {
    await saleViewModel.getProductsBySaleId(saleId);
    notifyListeners();
  }
}
