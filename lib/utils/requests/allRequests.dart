import 'dart:convert';

import 'package:mps_app/utils/classes/orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class allRequests {
  
  static login(email, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': password};
    var response = await http
        .post(Uri.parse("http://127.0.0.1:8000/api/jwt/login"), body: data);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      sharedPreferences.setString("token", jsonResponse['access_token']);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static Future<List> getInvoiceOrders() async {
    var response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/jwt/invoiceOrders'));
    var decodedResponse =
        json.decode(response.body).cast<Map<String, dynamic>>();
    List<Order> orders = await decodedResponse
        .map<Order>((json) => Order.fromJson(json))
        .toList();
    return orders;
  }

  static Future<int> postData(url, data) async {
    try {
      final response = await http.post(Uri.parse(url), body: data);
      return response.statusCode;
    } catch (er) {
      print(er);
      return 400;
    }
  }


  static getOrderSource() async {
    List orders = await allRequests.getInvoiceOrders();
    List<dynamic> ordersList = [];

    for (var order in orders) {
      ordersList.add({
        'id': order.id,
        'invoice': order.invoice.invoiceNumber,
        'lastName': order.family.lastName
      });
    }
    return ordersList;
  }


  static logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
  }
}
