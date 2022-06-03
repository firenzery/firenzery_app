import 'package:flutter/material.dart';

class AdressModel extends ChangeNotifier {
  int? idAdress;
  int? idClient;
  int? group;
  int? apartment;
  String? block;

  AdressModel(
      {this.idAdress, this.idClient, this.group, this.apartment, this.block});

  AdressModel.fromJson(Map<String, dynamic> json) {
    idAdress = json['idAdress'];
    idClient = json['idClient'];
    group = json['group'];
    apartment = json['apartment'];
    block = json['block'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idClient'] = idClient;
    data['idAdress'] = idAdress;
    data['group'] = group;
    data['apartment'] = apartment;
    data['block'] = block;
    return data;
  }
}
