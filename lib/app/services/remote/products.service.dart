import 'package:firenzery/app/interfaces/client_http.interface.dart';
import 'package:firenzery/app/interfaces/products.interface.dart';

class ProductsService implements IProducts {
  final IClientHttp client;
  final String url = "http://192.168.100.11:8080";

  ProductsService(this.client);

  @override
  Future getAllProducts() async {
    return await client.get("$url/products");
  }
}
