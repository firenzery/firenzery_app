import 'package:firenzery/app/interfaces/categories.interface.dart';
import 'package:firenzery/app/interfaces/client_http.interface.dart';

class CategoriesService implements ICategories {
  final IClientHttp client;
  final String url = "http://192.168.100.11:8080";

  CategoriesService(this.client);

  @override
  Future getAllCategories() async {
    return await client.get("$url/categories");
  }
}
