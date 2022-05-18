import 'package:firenzery/app/interfaces/client_http.interface.dart';
import 'package:firenzery/app/interfaces/user.interface.dart';
import 'package:firenzery/app/models/user.model.dart';

class UserService implements IUser {
  final IClientHttp client;

  UserService(this.client);

  @override
  Future getUser(int id) async {
    return await client.get("http://172.22.128.1:8080/client/$id");
  }

  @override
  Future login(String email, String password) async {
    return await client.post("http://172.22.128.1:8080/client/login",
        {"email": email, "password": password});
  }

  @override
  Future register(UserModel user) async {
    var json = {
      "firstName": user.firstName,
      "surname": user.surname,
      "dateNasc": user.dateNasc,
      "email": user.email,
      "password": user.password,
      "cpf": user.cpf,
      "nrPhone": user.nrPhone
    };

    return await client.post("http://172.22.128.1:8080/client", json);
  }
}
