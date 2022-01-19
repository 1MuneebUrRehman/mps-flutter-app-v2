import 'package:flutter/material.dart';
import 'package:mps_app/widgets/home_widgets.dart';

class CemeteryHome extends StatefulWidget {
  const CemeteryHome({Key? key}) : super(key: key);

  @override
  _CemeteryHomeState createState() => _CemeteryHomeState();
}

class _CemeteryHomeState extends State<CemeteryHome> {
  final String title = "CEMETERY";
  final String btnTxt1 = "CEMETERY-BTN";
  final String btnTxt2 = "CEMETERY-BTN";
  final String btnTxt3 = "CEMETERY-BTN";
  final String url1 = "";
  final String url2 = "";
  final String url3 = "";

  @override
  Widget build(BuildContext context) {
    return HomeWidget(
      title: title,
      btn1: btnTxt1,
      btn2: btnTxt2,
      btn3: btnTxt3,
      url1: url1,
      url2: url2,
      url3: url3,
    );
  }
}
