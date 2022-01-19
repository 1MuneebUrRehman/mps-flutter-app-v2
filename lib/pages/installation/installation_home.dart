import 'package:flutter/material.dart';
import 'package:mps_app/widgets/home_widgets.dart';

class InstallationHome extends StatefulWidget {
  const InstallationHome({Key? key}) : super(key: key);

  @override
  _InstallationHomeState createState() => _InstallationHomeState();
}

class _InstallationHomeState extends State<InstallationHome> {
  final String title = "INSTALLATION";
  final String btnTxt1 = "INSTALLATION-BTN";
  final String btnTxt2 = "INSTALLATION-BTN";
  final String btnTxt3 = "INSTALLATION-BTN";
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
