import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  int? idClient;
  String? firstName;
  String? surname;
  String? dateNasc;
  String? email;
  String? password;
  int? cpf;
  int? nrPhone;

  UserModel(
      {this.idClient,
      this.firstName,
      this.surname,
      this.dateNasc,
      this.email,
      this.password,
      this.cpf,
      this.nrPhone});

  UserModel.fromJson(Map<String, dynamic> json) {
    idClient = json['ID_CLIENT'];
    firstName = json['FIRST_NAME'];
    surname = json['SURNAME'];
    dateNasc = json['DATE_NASC'];
    email = json['EMAIL'];
    password = json['PASSWORD'];
    cpf = json['CPF'];
    nrPhone = json['NR_PHONE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID_CLIENT'] = idClient;
    data['FIRST_NAME'] = firstName;
    data['SURNAME'] = surname;
    data['DATE_NASC'] = dateNasc;
    data['EMAIL'] = email;
    data['PASSWORD'] = password;
    data['CPF'] = cpf;
    data['NR_PHONE'] = nrPhone;
    return data;
  }
}
