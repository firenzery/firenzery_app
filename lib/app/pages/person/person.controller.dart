import 'package:firenzery/app/interfaces/locale_storage.interface.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/pages/person/person.page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PersonController extends PersonPage {
  ILocaleStorage service;

  PersonController(this.service) : super([], [], AdressModel());

  exit(context, categories, products, adress) async {
    await service.removeValue('email');
    await service.removeValue('password');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(categories, products)),
    );
  }
}
