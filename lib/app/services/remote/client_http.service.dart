import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firenzery/app/interfaces/client_http.interface.dart';

class ClientHttpSevice implements IClientHttp {
  @override
  void addToken(String token) {}

  @override
  Future get(url) async {
    try {
      return await http.get(Uri.parse(url));
    } catch (error) {
      throw error;
    }
  }

  @override
  Future post(url, body) async {
    try {
      String data = json.encode(body);
      return await http.post(
        Uri.parse(url),
        body: data,
        headers: {"Content-Type": "application/json"},
      );
    } catch (error) {
      throw error;
    }
  }

  @override
  Future put(url, body) async {
    try {
      String data = json.encode(body);
      return await http.put(
        Uri.parse(url),
        body: data,
        headers: {"Content-Type": "application/json"},
      );
    } catch (error) {
      throw error;
    }
  }
}
