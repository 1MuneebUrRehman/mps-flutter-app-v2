import 'package:flutter/material.dart';
import 'package:mps_app/widgets/home_widgets.dart';

class InstallationHome extends StatefulWidget {
  const InstallationHome({Key? key}) : super(key: key);

  @override
  _InstallationHomeState createState() => _InstallationHomeState();
}

class _InstallationHomeState extends State<InstallationHome> {
  final String title = "INSTALLATION";
  final String btn1 = "INSTALLATION-BTN";
  final String btn2 = "INSTALLATION-BTN";
  final String btn3 = "INSTALLATION-BTN";

  @override
  Widget build(BuildContext context) {
    return HomeWidget(title: title, btn1: btn1, btn2: btn2, btn3: btn3);
  }
}
