import 'package:firenzery/app/pages/list_products/list_products.page.dart';

class ListProductsController extends ListProductsPage {
  final List allProducts;
  final int? categoryId;
  final String title;

  const ListProductsController(
      {required this.allProducts, this.categoryId, required this.title})
      : super(allProducts: allProducts, categoryId: categoryId, title: title);

  getProductsbyCategory(int categoryId) {
    return allProducts.where((data) => data.type == categoryId).toList();
  }
}
