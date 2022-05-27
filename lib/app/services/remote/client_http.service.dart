import 'package:dio/dio.dart';
import 'package:firenzery/app/interfaces/client_http.interface.dart';

class ClientHttpSevice implements IClientHttp {
  final Dio dio = Dio();

  @override
  void addToken(String token) {}

  @override
  Future get(String url) async {
    var response = await dio.get(url);
    return response;
  }

  @override
  Future post(String url, Object body) async {
    var response = await dio.post(url, data: body);
    return response;
  }

  @override
  Future put(String url, Object body) async {
    var response = await dio.put(url, data: body);
    return response;
  }
}
