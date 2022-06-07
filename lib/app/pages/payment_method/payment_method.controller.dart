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
          payment: 1,
          name: 'DINHEIRO',
          paymentType: 1,
          icon: const Icon(
            Icons.payments,
            color: Colors.green,
          )));
      paymentMethodValues.add(PaymentMethodModel(
          payment: 2,
          name: 'CARTÃO DE DÉBITO',
          paymentType: 1,
          icon: const Icon(Icons.credit_card)));
      paymentMethodValues.add(PaymentMethodModel(
          payment: 3,
          name: 'CARTÃO DE CRÉDITO',
          paymentType: 1,
          icon: const Icon(Icons.credit_card)));
    }
  }
}
