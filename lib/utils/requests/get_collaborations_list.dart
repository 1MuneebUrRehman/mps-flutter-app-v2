import 'package:flutter/material.dart';
import 'package:mps_app/utils/classes/custom_shared_preferences.dart';
import 'package:mps_app/utils/utility.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

Future<OrderDataGridSource> getCollaborationsList(String url) async {
  // Return Get Data
  var productList =
      await generateProductList(Utility.baseUrl + "collaboration/index");
  return OrderDataGridSource(productList);
}

List<GridColumn> getColumns() {
  return <GridColumn>[
    GridColumn(
        columnName: 'Id',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text('Index', overflow: TextOverflow.ellipsis))),
    GridColumn(
        columnName: 'collaborationId',
        visible: false,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text('Collaboration ID',
                overflow: TextOverflow.ellipsis))),
    GridColumn(
        columnName: 'Date',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text('Date', overflow: TextOverflow.ellipsis))),
    GridColumn(
        columnName: 'Is_Installation',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text('Is_Installation',
                overflow: TextOverflow.ellipsis))),
  ];
}

// Get Request
Future<List<Collaborations>> generateProductList(String url) async {
  var token = CustomSharedPreferences.getToken();

  var response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "Access-Control_Allow_Origin": "*",
    'Authorization': 'Bearer $token',
  });
  // Decode Data
  var decodedProducts = json.decode(response.body).cast<Map<String, dynamic>>();
  // Convert to List Collaborations
  List<Collaborations> productList = await decodedProducts
      .map<Collaborations>((json) => Collaborations.fromJson(json))
      .toList();
  return productList;
}

class OrderDataGridSource extends DataGridSource {
  OrderDataGridSource(this.productList) {
    // Generate Rows of List Data
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Collaborations> productList;

  @override
  List<DataGridRow> get rows => dataGridRows;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }

  void buildDataGridRow() {
    // Build Grid Row
      var i = 0;
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'Id', value: ++i),
        DataGridCell<int>(columnName: 'collaborationId', value: dataGridRow.id),
        DataGridCell<String>(columnName: 'Date', value: dataGridRow.order.date),
        DataGridCell<String>(
            columnName: 'Is_Installation',
            value: dataGridRow.order.isinstallation),
      ]);
    }).toList();
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}

class Collaborations {
  final int id;
  final Order order;

  Collaborations({
    required this.id,
    required this.order,
  });

  factory Collaborations.fromJson(Map<String, dynamic> json) {
    return Collaborations(
      id: json['id'],
      order: Order.fromJson(json['order']),
    );
  }
}

class Order {
  final int orderid;
  final String? date;
  final String isinstallation;

  Order({
    required this.orderid,
    required this.date,
    required this.isinstallation,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderid: json['id'],
      date: DateFormat("yyyy-MM-dd").format(DateTime.parse(json['date'])),
      isinstallation: json['is_installation'].toString(),
    );
  }
}
