import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

import '../constante/app_key.dart';

class MyServices {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    log('SharedPreferences initialized successfully');
  }

 Future<bool> sharedSet<T>({required T value, required String key}) async {
    if (_sharedPreferences == null) {
      await init();
    }

    try {
      final result = switch (value) {
        String v => await _sharedPreferences!.setString(key, v),
        int v => await _sharedPreferences!.setInt(key, v),
        bool v => await _sharedPreferences!.setBool(key, v),
        double v => await _sharedPreferences!.setDouble(key, v),
        List<String> v => await _sharedPreferences!.setStringList(key, v),
        _ => throw ArgumentError("Unsupported value type")
      };

      log("Value set successfully for key: $key and Value: $value");
      return result;
    } catch (e) {
      log("Error setting value for key $key: $e");
      return false;
    }
  }

  Future<T?> sharedGet<T>({required String key}) async {
    try {
      assert(key.isNotEmpty, 'Key cannot be empty');
      if (_sharedPreferences == null) {
        await init();
      }

      final value = switch (T) {
        String => _sharedPreferences!.getString(key) as T?,
        int => _sharedPreferences!.getInt(key) as T?,
        bool => _sharedPreferences!.getBool(key) as T?,
        double => _sharedPreferences!.getDouble(key) as T?,
      List=> _sharedPreferences!.getStringList(key) as T?,
      _ => null
      };

      log('Retrieved value for key "$key": $value');
      return value;
    } catch (e) {
      log('Error getting value for key "$key": $e');
      return null;
    }
  }

  static Future<String> getToken() async {
    try {
      await init();
final myService=MyServices();
      final token = await  myService.sharedGet<String>(key: DataKey.token);
      log("Retrieved token: $token");
      return token ?? "";
    } catch (e) {
      log("Error retrieving token: $e");
      return "";
    }
  }   static Future<Object> removeToken() async {
    try {
      await init();
      final token = await  MyServices.sharedRemove(key: DataKey.token);
      log("Retrieved token: $token");
      return token ;
    } catch (e) {
      log("Error retrieving token: $e");
      return "";
    }
  }  static Future<Object> setToken({required String tokenValue}) async {
    try {
      await init();
      final myService=MyServices();

      final token = await  myService.sharedSet<String>(key: DataKey.token, value: tokenValue);
      log("Retrieved token: $token");
      return token ;
    } catch (e) {
      log("Error retrieving token: $e");
      return "";
    }
  }

  static Future<bool> sharedRemove({required String key}) async {
    try {
      assert(key.isNotEmpty, 'Key cannot be empty');
      if (_sharedPreferences == null) {
        await init();
      }
      final result = await _sharedPreferences!.remove(key);
      log('Successfully removed key "$key"');
      return result;
    } catch (e) {
      log('Error removing key "$key": $e');
      return false;
    }
  }

  static Future<bool> sharedClear() async {
    try {
      if (_sharedPreferences == null) {
        await init();
      }
      final result = await _sharedPreferences!.clear();
      log('Successfully cleared all SharedPreferences');
      return result;
    } catch (e) {
      log('Error clearing SharedPreferences: $e');
      return false;
    }
  }

  // Helper static methods
  static Future<bool> hasKey(String key) async {
    if (_sharedPreferences == null) {
      await init();
    }
    return _sharedPreferences!.containsKey(key);
  }

  static Future<Set<String>> getAllKeys() async {
    if (_sharedPreferences == null) {
      await init();
    }
    return _sharedPreferences!.getKeys();
  }
}