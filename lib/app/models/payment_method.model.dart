import 'package:flutter/material.dart';

class PaymentMethodModel {
  int? type;
  String? name;
  bool? paymentApp;
  Icon? icon;

  PaymentMethodModel({this.type, this.name, this.paymentApp, this.icon});
}
