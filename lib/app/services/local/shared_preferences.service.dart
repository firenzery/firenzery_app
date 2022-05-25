import 'package:firenzery/app/interfaces/locale_storage.interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements ILocaleStorage {
  getValue(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.get(key);
    return value;
  }

  addValue(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value.isInteger()) {
      prefs.setInt(key, value);
    } else if (value.isString()) {
      prefs.setString(key, value);
    } else if (value.isBoolean()) {
      prefs.setBool(key, value);
    } else if (value.isDouble()) {
      prefs.setDouble(key, value);
    }
  }

  removeValue(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
