import 'package:flutter/material.dart';
import 'package:mps_app/widgets/form_list.dart';

class PorcelainFormList extends StatefulWidget {
  const PorcelainFormList({Key? key}) : super(key: key);

  @override
  _PorcelainFormListState createState() => _PorcelainFormListState();
}

class _PorcelainFormListState extends State<PorcelainFormList> {
  String title = "OC Picture (Porcelain) Production Form";
  String urlRoute = "/productionPicture/index";
  String urlAdd = "/productionPicture/add";
  String url = "http://127.0.0.1:8000/api/jwt/productionPicture/index";
  String addUrl = "http://127.0.0.1:8000/api/jwt/productionPicture/store";
  // String removeUrl = "";
  // String editUrl = "";

  @override
  Widget build(BuildContext context) {
    return FormListWidget(title: title, url: url, urlRoute: urlRoute, urlAdd: urlAdd);
  }
}
