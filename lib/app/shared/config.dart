import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String? get title => dotenv.env['TITLE'];
  static String? get baseUrl => dotenv.env['BASE_URL'];
  static String? get environment => dotenv.env['ENVIROMENT'];
}
