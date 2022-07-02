import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/models/sale.model.dart';

abstract class ISales {
  Future getSalesByUser(int idClient);
  Future addSaleByUser(SaleModel sale, List<ProductModel> products);
  Future getProductsBySaleId(int idSale);
  Future alterStateSale(int idSale, int state);
}
