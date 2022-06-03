import 'package:firenzery/app/interfaces/adress.interface.dart';
import 'package:firenzery/app/interfaces/client_http.interface.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/shared/config.dart';

class AdressService implements IAdress {
  final IClientHttp client;
  String? url = Config.baseUrl;

  AdressService(this.client);

  @override
  Future getAdress(int clientId) async {
    try {
      return await client.get("$url/adress/$clientId");
    } catch (error) {
      throw error;
    }
  }

  @override
  Future updateAdress(AdressModel adress) async {
    try {
      return await client.put("$url/adress/update", adress);
    } catch (error) {
      throw error;
    }
  }

  @override
  Future createAdress(AdressModel adress) async {
    try {
      return await client.post("$url/adress", adress);
    } catch (error) {
      throw error;
    }
  }
}
