import 'package:firenzery/app/interfaces/client_http.interface.dart';
import 'package:firenzery/app/interfaces/user.interface.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/shared/config.dart';

class UserService implements IUser {
  final IClientHttp client;
  String? url = Config.baseUrl;

  UserService(this.client);

  @override
  Future getUser(id) async {
    return await client.get("$url/client/$id");
  }

  @override
  Future login(String email, String password) async {
    return await client
        .post("$url/client/login", {"email": email, "password": password});
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

    try {
      return await client.post("$url/client", json);
    } catch (error) {
      return error;
    }
  }
}
