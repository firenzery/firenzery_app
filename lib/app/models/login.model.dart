class LoginModel {
  int? passed;
  String? message;

  LoginModel({this.passed, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    passed = json['passed'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['passed'] = passed;
    data['message'] = message;
    return data;
  }
}