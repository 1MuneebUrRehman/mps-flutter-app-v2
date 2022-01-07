import 'package:flutter/material.dart';
import 'package:mps_app/widgets/home_widgets.dart';

class ProductionHome extends StatefulWidget {
  const ProductionHome({Key? key}) : super(key: key);

  @override
  _ProductionHomeState createState() => _ProductionHomeState();
}

class _ProductionHomeState extends State<ProductionHome> {
  final String title = "PRODUCTION";
  final String btnTxt1 = "Porcelain (OC)";
  final String btnTxt2 = "Laser";
  final String btnTxt3 = "Sandblasting";

  @override
  Widget build(BuildContext context) {
    return HomeWidget(
        title: title, btn1: btnTxt1, btn2: btnTxt2, btn3: btnTxt3);
  }
}
