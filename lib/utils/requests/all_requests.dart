import 'dart:convert';
import 'package:mps_app/utils/classes/orders.dart';
import 'package:mps_app/utils/classes/custom_shared_preferences.dart';
import 'package:mps_app/utils/utility.dart';
import 'package:http/http.dart' as http;

class AllRequests {
  static String loginUrl = "http://127.0.0.1:8000/api/login";

  static login(email, password) async {
    Map data = {'email': email, 'password': password};
    var response = await http.post(Uri.parse(loginUrl), body: data);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      await CustomSharedPreferences.setToken(jsonResponse['auth_token']);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static Future<List> getInvoiceOrders() async {
    var token = CustomSharedPreferences.getToken();
    var response =
        await http.get(Uri.parse(Utility.baseUrl + "invoiceOrders"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var decodedResponse =
        json.decode(response.body).cast<Map<String, dynamic>>();
    List<Order> orders = await decodedResponse
        .map<Order>((json) => Order.fromJson(json))
        .toList();
    return orders;
  }

  static Future<int> postData(url, data) async {
    var token = CustomSharedPreferences.getToken();
    try {
      final response =
          await http.post(Uri.parse(url), body: json.encode(data), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      return response.statusCode;
    } catch (er) {
      return 400;
    }
  }

  static getOrderSource() async {
    List orders = await AllRequests.getInvoiceOrders();
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

  static deleteData(deleteUrl) async {
    var token = CustomSharedPreferences.getToken();
    var response = await http.post(Uri.parse(deleteUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return response.statusCode;
  }

  static showData(url) async {
    var token = CustomSharedPreferences.getToken();

    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final decodedResponse = jsonDecode(response.body) as Map;
    return decodedResponse;
  }

  static logOut() async {
    CustomSharedPreferences.removeToken();
  }
}
