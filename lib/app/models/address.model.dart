class AdressModel {
  int? idAdress;
  int? idClient;
  int? group;
  int? apartment;

  AdressModel({this.idAdress, this.idClient, this.group, this.apartment});

  AdressModel.fromJson(Map<String, dynamic> json) {
    idAdress = json['idAdress'];
    idClient = json['idClient'];
    group = json['group'];
    apartment = json['apartment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idClient'] = idClient;
    data['idAdress'] = idAdress;
    data['group'] = group;
    data['apartment'] = apartment;
    return data;
  }
}
