import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreferences{

  static SharedPreferences? _preferences;
  static const _keyToken = 'token';
  
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setToken(String token) async => await _preferences?.setString(_keyToken, token);

  static String? getToken() => _preferences?.getString(_keyToken);

  static Future<bool>? removeToken() => _preferences?.remove("token");
}