import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetRequest {
  static login(email, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': password};
    var response = await http.post(Uri.parse("http://mps.local/api/jwt/login"),
        body: data);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      sharedPreferences.setString("token", jsonResponse['access_token']);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
  }
}
