import 'package:firenzery/app/models/sale.model.dart';
import 'package:firenzery/app/viewmodels/sale.viewmodel.dart';
import 'package:flutter/material.dart';

enum StateSaleEnum { pending, canceled, completed }

enum ResponseStateSaleEnum { idle, success, error, loading }

class RequestDetailController extends ChangeNotifier {
  ResponseStateSaleEnum responseStateSale = ResponseStateSaleEnum.idle;

  refreshValues() {
    notifyListeners();
  }

  getProductsBySaleId(SaleViewModel saleViewModel, int saleId) async {
    await saleViewModel.getProductsBySaleId(saleId);
    notifyListeners();
  }

  alterSale(SaleViewModel saleViewModel, SaleModel sale) async {
    responseStateSale = ResponseStateSaleEnum.loading;
    notifyListeners();

    var resp = await saleViewModel.alterSale(sale);
    if (resp.statusCode == 200) {
      responseStateSale = ResponseStateSaleEnum.success;
      notifyListeners();
    } else {
      responseStateSale = ResponseStateSaleEnum.error;
      notifyListeners();
    }
  }

  getStateByEnum(StateSaleEnum state) {
    switch (state) {
      case StateSaleEnum.pending:
        return 0;
      case StateSaleEnum.completed:
        return 1;
      case StateSaleEnum.canceled:
        return 2;
    }
  }
}