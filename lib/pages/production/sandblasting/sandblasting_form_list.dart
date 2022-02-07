import 'package:flutter/material.dart';
import 'package:mps_app/utils/utility.dart';
import 'package:mps_app/widgets/form_list.dart';

class SandBlastingFormList extends StatefulWidget {
  const SandBlastingFormList({Key? key}) : super(key: key);

  @override
  _SandBlastingFormListState createState() => _SandBlastingFormListState();
}

class _SandBlastingFormListState extends State<SandBlastingFormList> {
  String title = "Sandblasting Production Form";
  String urlRoute = "/productionSandblasting/index";
  String urlAdd = "/productionSandblasting/add";
  String url = Utility.baseUrl + "productionSandblasting/index";
  String addUrl = Utility.baseUrl + "productionSandblasting/store";
  String removeUrl = Utility.baseUrl + "productionSandblasting/destroy/";
  // String editUrl = "";

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
