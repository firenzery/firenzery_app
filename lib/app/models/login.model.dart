class LoginModel {
  int? idClient;
  int? passed;
  String? message;

  LoginModel({this.idClient, this.passed, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    idClient = json['idClient'];
    passed = json['passed'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idClient'] = idClient;
    data['passed'] = passed;
    data['message'] = message;
    return data;
  }
}
