import 'package:firenzery/app/interfaces/adress.interface.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/services/remote/adress.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class AdressViewModel extends ChangeNotifier {
  IAdress service = AdressService(ClientHttpSevice());

  AdressModel adressModel = AdressModel();

  refreshValues() {
    notifyListeners();
  }

  getAdress(int clientId) async {
    try {
      var adress = await service.getAdress(clientId);

      adressModel = AdressModel.fromJson(convert.jsonDecode(adress.body));

      notifyListeners();

      return adress;
    } catch (error) {
      throw error;
    }
  }

  createAdress(AdressModel adress) async {
    try {
      var newAdress = await service.createAdress(adress);

      adressModel = AdressModel.fromJson(convert.jsonDecode(newAdress.body));

      notifyListeners();

      return newAdress;
    } catch (error) {
      throw error;
    }
  }

  updateAdress(adress) async {
    try {
      var newAdress = await service.updateAdress(adress);

      adressModel = AdressModel.fromJson(convert.jsonDecode(newAdress.body));

      notifyListeners();

      return newAdress;
    } catch (error) {
      throw error;
    }
  }
}
