import 'package:flutter/material.dart';
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
        width: 100,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child:
                const Text('ID', overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'Date',
        width: 100,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: const Text('Date',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'Week',
        width: 100,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('Week',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'Entries',
        width: 100,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: const Text('Entries',
                overflow: TextOverflow.clip, softWrap: true))),
  ];
}

// Get Request
Future<List<Product>> generateProductList(String url) async {
  var response =
      await http.get(Uri.parse(url));
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
    return DataGridRowAdapter(cells: [
      Container(
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          DateFormat('MM/dd/yyyy').format(row.getCells()[1].value).toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }

  void buildDataGridRow() {
    // Build Grid Row
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'Id', value: dataGridRow.id),
        DataGridCell<DateTime>(columnName: 'Date', value: dataGridRow.date),
        DataGridCell<String>(columnName: 'Week', value: dataGridRow.week_of),
        DataGridCell<int>(
            columnName: 'Entries', value: dataGridRow.total_entries),
      ]);
    }).toList(growable: false);
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}

class Product {
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        date: DateTime.parse(json['date']),
        week_of: json['week_of'],
        total_entries: json['total_entries']);
  }
  Product({
    required this.id,
    required this.date,
    required this.week_of,
    required this.total_entries,
  });
  final int? id;
  final DateTime? date;
  final String? week_of;
  final int? total_entries;
}
