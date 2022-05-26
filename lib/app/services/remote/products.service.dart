import 'package:firenzery/app/interfaces/client_http.interface.dart';
import 'package:firenzery/app/interfaces/products.interface.dart';
import 'package:firenzery/app/shared/config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductsService implements IProducts {
  final IClientHttp client;
  String? url = Config.baseUrl;

  ProductsService(this.client);

  @override
  Future getAllProducts() async {
    return await client.get("$url/products");
  }
}
