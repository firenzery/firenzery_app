import 'package:firenzery/app/interfaces/adress.interface.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class AdressViewModel {
  IAdress service;

  AdressViewModel(this.service);

  ValueNotifier<AdressModel> adressModel =
      ValueNotifier<AdressModel>(AdressModel());

  getAdress(clientId) async {
    try {
      var adress = await service.getAdress(clientId);

      adressModel.value = AdressModel.fromJson(convert.jsonDecode(adress.body));

      return adress;
    } catch (error) {
      throw error;
    }
  }

  createAdress(adress) async {
    try {
      var newAdress = await service.createAdress(adress);

      adressModel.value =
          AdressModel.fromJson(convert.jsonDecode(newAdress.body));

      return newAdress;
    } catch (error) {
      throw error;
    }
  }

  updateAdress(adress) async {
    try {
      var newAdress = await service.updateAdress(adress);

      adressModel.value =
          AdressModel.fromJson(convert.jsonDecode(newAdress.body));

      return newAdress;
    } catch (error) {
      throw error;
    }
  }
}
