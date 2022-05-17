import 'package:firenzery/app/models/user.model.dart';

abstract class IUser {
  Future getUser(int id);
  Future login(String email, String password);
  Future register(UserModel user);
}
