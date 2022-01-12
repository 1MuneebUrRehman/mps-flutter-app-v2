import 'package:flutter/material.dart';
import 'package:mps_app/widgets/form_list.dart';

class LaserFormList extends StatefulWidget {
  const LaserFormList({Key? key}) : super(key: key);

  @override
  _LaserFormListState createState() => _LaserFormListState();
}

class _LaserFormListState extends State<LaserFormList> {
  String title = "Laser Production Form";
  String urlRoute = "/productionLaser/index";
  String urlAdd = "/productionLaser/add";
  String url = "http://127.0.0.1:8000/api/jwt/productionLaser/index";
  String addUrl = "http://127.0.0.1:8000/api/jwt/productionLaser/store";
  String removeUrl = "http://127.0.0.1:8000/api/jwt/productionLaser/destroy/";
  
  @override
  Widget build(BuildContext context) {
    return FormListWidget(
      title: title,
      url: url,
      urlRoute: urlRoute,
      urlAdd: urlAdd,
      removeUrl: removeUrl,
    );
  }
}
