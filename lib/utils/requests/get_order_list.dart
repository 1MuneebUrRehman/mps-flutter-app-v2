import 'package:flutter/material.dart';
import 'package:mps_app/utils/classes/custom_shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

Future<OrderDataGridSource> getOrderDataList(String url) async {
  // Return Get Data
  var productList = await generateProductList(url);
  return OrderDataGridSource(productList);
}

List<GridColumn> getColumns() {
  return <GridColumn>[
    GridColumn(
        columnName: 'Id',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text('ID', overflow: TextOverflow.ellipsis))),
    GridColumn(
        columnName: 'Date',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text('Date', overflow: TextOverflow.ellipsis))),
    GridColumn(
        columnName: 'Week',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text('Week', overflow: TextOverflow.ellipsis))),
    GridColumn(
        columnName: 'Entries',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text('Entries', overflow: TextOverflow.ellipsis))),
  ];
}

// Get Request
Future<List<Product>> generateProductList(String url) async {
  var token = CustomSharedPreferences.getToken();

  var response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  // Decode Data
  var decodedProducts = json.decode(response.body).cast<Map<String, dynamic>>();
  // Convert to List Product
  List<Product> productList = await decodedProducts
      .map<Product>((json) => Product.fromJson(json))
      .toList();
  return productList;
}

class OrderDataGridSource extends DataGridSource {
  OrderDataGridSource(this.productList) {
    // Generate Rows of List Data
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Product> productList;

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
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'Id', value: dataGridRow.id),
        DataGridCell<String>(columnName: 'Date', value: dataGridRow.date),
        DataGridCell<String>(columnName: 'Week', value: dataGridRow.weekOf),
        DataGridCell<int>(
            columnName: 'Entries', value: dataGridRow.totalEntries),
      ]);
    }).toList();
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}

class Product {
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        date: DateFormat("yyyy-MM-dd").format(DateTime.parse(json['date'])),
        weekOf: json['week_of'],
        totalEntries: json['total_entries']);
  }
  Product({
    required this.id,
    required this.date,
    required this.weekOf,
    required this.totalEntries,
  });
  final int? id;
  final String? date;
  final String? weekOf;
  final int? totalEntries;
}
