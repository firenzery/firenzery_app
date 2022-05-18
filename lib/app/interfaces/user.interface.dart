abstract class IUser {
  Future getUser(int id);
  Future login(String email, String password);
}
