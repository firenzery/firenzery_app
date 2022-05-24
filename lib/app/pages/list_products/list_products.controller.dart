import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/pages/list_products/list_products.page.dart';

class ListProductsController extends ListProductsPage {
  final List allProducts;
  final int categoryId;
  final String title;

  ListProductsController(this.allProducts, this.categoryId, this.title)
      : super(allProducts, categoryId, title);

  getProductsbyCategory(categoryId) {
    return allProducts.where((data) => data.type == categoryId).toList();
  }
}
