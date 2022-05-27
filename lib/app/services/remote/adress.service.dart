import 'package:firenzery/app/interfaces/adress.interface.dart';
import 'package:firenzery/app/interfaces/client_http.interface.dart';
import 'package:firenzery/app/shared/config.dart';

class AdressService implements IAdress {
  final IClientHttp client;
  String? url = Config.baseUrl;

  AdressService(this.client);

  @override
  Future getAdress(clientId) async {
    try {
      return await client.get("$url/adress/$clientId");
    } catch (error) {
      return throw Error();
    }
  }

  @override
  Future updateAdress(adress) async {
    try {
      return await client.put("$url/adress/update", adress);
    } catch (error) {
      return throw Error();
    }
  }

  @override
  Future createAdress(adress) async {
    try {
      return await client.post("$url/adress", adress);
    } catch (error) {
      return throw Error();
    }
  }
}
