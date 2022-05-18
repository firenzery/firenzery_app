import 'package:firenzery/app/interfaces/client_http.interface.dart';
import 'package:firenzery/app/interfaces/user.interface.dart';

class UserService implements IUser {
  final IClientHttp client;

  UserService(this.client);

  @override
  Future getUser(int id) async {
    return await client.get("http://localhost:8080/client/$id");
  }

  @override
  Future login(String email, String password) async {
    var response = await client.post("http://localhost:8080/client/login",
        {"email": email, "password": password});

    return response;
  }
}
