import 'package:flutter/material.dart';
import 'package:mps_app/widgets/home_widgets.dart';

class CemeteryHome extends StatefulWidget {
  const CemeteryHome({Key? key}) : super(key: key);

  @override
  _CemeteryHomeState createState() => _CemeteryHomeState();
}

class _CemeteryHomeState extends State<CemeteryHome> {
  final String title = "CEMETERY";
  final String btn1 = "CEMETERY-BTN";
  final String btn2 = "CEMETERY-BTN";
  final String btn3 = "CEMETERY-BTN";

  @override
  Widget build(BuildContext context) {
    return HomeWidget(title: title, btn1: btn1, btn2: btn2, btn3: btn3);
  }
}
