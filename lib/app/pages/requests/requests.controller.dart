import 'package:firenzery/app/viewmodels/sale.viewmodel.dart';
import 'package:flutter/material.dart';

class RequestController extends ChangeNotifier {
  setPayment(int payment) {
    switch (payment) {
      case 1:
        return 'DINHEIRO';
      case 2:
        return 'CARTÃO DE DÉBITO';
      case 3:
        return 'CARTÃO DE CRÉDITO';
      default:
    }
  }

  setPaymentType(int paymentType) {
    switch (paymentType) {
      case 1:
        return 'Pagamento na entrega';
      case 2:
        return 'Pagamento pelo app';
      default:
    }
  }

  setColorState(int state) {
    switch (state) {
      case 0:
        return Colors.yellow;
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      default:
    }
  }

  getSales(int idClient, SaleViewModel saleViewModel) async {
    await saleViewModel.getSalesByUser(idClient);
    notifyListeners();
  }
}
