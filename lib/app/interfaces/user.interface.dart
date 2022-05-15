import 'package:firenzery/app/models/user.model.dart';

import '../models/login.model.dart';

abstract class IUser {
  Future<UserModel> getUser(int id);
  Future<LoginModel> login(String email, String password);
}