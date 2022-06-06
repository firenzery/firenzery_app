import 'package:firenzery/app/models/payment_method.model.dart';
import 'package:flutter/material.dart';

class PaymentMethodController extends ChangeNotifier {
  final List<PaymentMethodModel> paymentMethodValues = [];
  PaymentMethodModel? paymentSelected;

  refreshValues() {
    notifyListeners();
  }

  getPaymentMethodValues() {
    if (paymentMethodValues.isEmpty) {
      paymentMethodValues.add(PaymentMethodModel(
          type: 1,
          name: 'DINHEIRO',
          paymentApp: false,
          icon: const Icon(
            Icons.payments,
            color: Colors.green,
          )));
      paymentMethodValues.add(PaymentMethodModel(
          type: 2,
          name: 'CARTÃO DE DÉBITO',
          paymentApp: false,
          icon: const Icon(Icons.credit_card)));
      paymentMethodValues.add(PaymentMethodModel(
          type: 3,
          name: 'CARTÃO DE CRÉDITO',
          paymentApp: false,
          icon: const Icon(Icons.credit_card)));
    }
  }
}
