import 'package:flutter/material.dart';
import 'package:mps_app/utils/utility.dart';
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
  String url = Utility.baseUrl + "productionPicture/index";
  String addUrl = Utility.baseUrl + "productionPicture/store";
  String removeUrl = Utility.baseUrl + "productionPicture/destroy/";

  @override
  void initState() {
    super.initState();
  }

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
