import 'package:flutter/material.dart';
import 'package:mps_app/widgets/bottom_navigation.dart';
import 'package:mps_app/widgets/navigation_drawer.dart';
import 'package:mps_app/widgets/reuseable_widgets.dart';
import 'package:mps_app/widgets/text.dart';

class HomeWidget extends StatefulWidget {
  final String title;
  final String btn1;
  final String btn2;
  final String btn3;
  final String url1;
  final String url2;
  final String url3;

  const HomeWidget({
    Key? key,
    required this.title,
    required this.btn1,
    required this.btn2,
    required this.btn3,
    required this.url1,
    required this.url2,
    required this.url3,
  }) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar(),
      drawer: const NavigationDrawerWidget(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextWidget(title: widget.title, fontSize: 30, color: Colors.blue),
          const Divider(
            indent: 60,
            endIndent: 60,
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
            title: ElevatedButton(
                onPressed: () {
                  if (widget.url1.isNotEmpty) {
                    Navigator.pushNamed(context, widget.url1);
                  }
                },
                child: TextWidget(
                  title: widget.btn1,
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
            title: ElevatedButton(
                onPressed: () {
                  if (widget.url2.isNotEmpty) {
                    Navigator.pushNamed(context, widget.url2);
                  }
                },
                child: TextWidget(
                  title: widget.btn2,
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
            title: ElevatedButton(
                onPressed: () {
                  if (widget.url3.isNotEmpty) {
                    Navigator.pushNamed(context, widget.url3);
                  }
                },
                child: TextWidget(
                  title: widget.btn3,
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
            title: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const TextWidget(
                  title: "Back",
                  color: Colors.black,
                  fontSize: 20,
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                )),
          ),
        ],
      )),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
