import 'package:flutter/material.dart';
import 'package:mps_app/utils/utility.dart';
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
  String url = Utility.baseUrl + "productionLaser/index";
  String addUrl = Utility.baseUrl + "productionLaser/store";
  String removeUrl = Utility.baseUrl + "productionLaser/destroy/";
  
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
