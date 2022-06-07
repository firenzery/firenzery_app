import 'package:firenzery/app/interfaces/client_http.interface.dart';
import 'package:firenzery/app/interfaces/sales.interface.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/models/sale.model.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/shared/config.dart';

class SalesService implements ISales {
  final IClientHttp client = ClientHttpSevice();
  String? url = Config.baseUrl;

  @override
  Future getSalesByUser(int idClient) async {
    try {
      return await client.get("$url/sales/$idClient");
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future addSaleByUser(SaleModel sale, List<ProductModel> products) async {
    try {
      return await client
          .post("$url/sales", {"sale": sale, "products": products});
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future getProductsBySaleId(int idSale) async {
    try {
      return await client.get("$url/sales/products/$idSale");
    } catch (err) {
      rethrow;
    }
  }
}
