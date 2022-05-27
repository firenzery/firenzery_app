import 'package:firenzery/app/interfaces/adress.interface.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:flutter/material.dart';

class AdressViewModel {
  IAdress service;

  AdressViewModel(this.service);

  ValueNotifier<AdressModel> adressModel =
      ValueNotifier<AdressModel>(AdressModel());

  getAdress(clientId) async {
    try {
      var adress = await service.getAdress(clientId);

      if (adress.data == '') {
        return AdressModel();
      }

      adressModel.value = AdressModel.fromJson(adress.data);

      return adressModel.value;
    } catch (error) {
      return AdressModel();
    }
  }

  createAdress(adress) async {
    var newAdress = await service.createAdress(adress);

    adressModel.value = AdressModel.fromJson(newAdress.data);

    return adressModel.value;
  }

  updateAdress(adress) async {
    var newAdress = await service.updateAdress(adress);

    adressModel.value = AdressModel.fromJson(newAdress.data);

    return adressModel.value;
  }
}
