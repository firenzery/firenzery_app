import 'package:flutter/material.dart';

class PaymentMethodModel {
  int? payment;
  String? name;
  int? paymentType;
  Icon? icon;

  PaymentMethodModel({this.payment, this.name, this.paymentType, this.icon});
}
