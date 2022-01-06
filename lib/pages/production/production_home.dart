import 'package:flutter/material.dart';
import 'package:mps_app/widgets/home_widgets.dart';

class ProductionHome extends StatefulWidget {
  const ProductionHome({Key? key}) : super(key: key);

  @override
  _ProductionHomeState createState() => _ProductionHomeState();
}

class _ProductionHomeState extends State<ProductionHome> {
  final String title = "PRODUCTION";
  final String btn1 = "Porcelain (OC)";
  final String btn2 = "Laser";
  final String btn3 = "Sandblasting";

  @override
  Widget build(BuildContext context) {
    return HomeWidget(title: title, btn1: btn1, btn2: btn2, btn3: btn3);
  }
}
