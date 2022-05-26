import 'package:firenzery/app/interfaces/categories.interface.dart';
import 'package:firenzery/app/interfaces/client_http.interface.dart';
import 'package:firenzery/app/shared/config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoriesService implements ICategories {
  final IClientHttp client;
  String? url = Config.baseUrl;

  CategoriesService(this.client);

  @override
  Future getAllCategories() async {
    return await client.get("$url/categories");
  }
}
