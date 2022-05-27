import 'package:firenzery/app/models/address.model.dart';

abstract class IAdress {
  Future getAdress(int clientId);
  Future updateAdress(AdressModel adress);
  Future createAdress(AdressModel adress);
}
