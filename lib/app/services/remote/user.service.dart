import 'package:firenzery/app/interfaces/client_http.interface.dart';
import 'package:firenzery/app/interfaces/user.interface.dart';
import 'package:firenzery/app/models/login.model.dart';
import 'package:firenzery/app/models/user.model.dart';

class UserService implements IUser{
  final IClientHttp client;

  UserService(this.client);

  @override
  Future<UserModel> getUser(int id) async {

    var json = await client.get("http://localhost:8080/client/${id}");

    UserModel model = UserModel.fromJson(json[0]);

    return model;

  }

  @override
  Future<LoginModel> login(String email, String password) async {

    var json = await client.post("http://localhost:8080/client/login", { "email": email, "password": password });

    LoginModel model = LoginModel.fromJson(json);

    return model;

  }

}
