import 'package:firenzery/app/interfaces/client_http.interface.dart';
import 'package:firenzery/app/interfaces/products.interface.dart';
import 'package:firenzery/app/shared/config.dart';

class ProductsService implements IProducts {
  final IClientHttp client;
  String? url = Config.baseUrl;

  ProductsService(this.client);

  @override
  Future getAllProducts() async {
    try {
      return await client.get("$url/products");
    } catch (error) {
      throw error;
    }
  }

  @override
  Future getNewArrivedProducts() async {
    try {
      return await client.get("$url/products/get-new-arrival-products");
    } catch (error) {
      throw error;
    }
  }
}
