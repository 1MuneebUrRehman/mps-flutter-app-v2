import 'package:flutter/material.dart';
import 'package:mps_app/pages/cemetery/cemetery_home.dart';
import 'package:mps_app/pages/installation/installation_home.dart';
import 'package:mps_app/pages/production/production_home.dart';
import 'package:mps_app/utils/requests/getRequest.dart';
import 'package:mps_app/widgets/bottom_navigation.dart';
import 'package:mps_app/widgets/navigation_drawer.dart';
import 'package:mps_app/widgets/reuseable_widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar(),
      drawer: const NavigationDrawerWidget(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 30.0),
                title: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InstallationHome()),
                      );
                    },
                    child: const Text(
                      "INSTALLATION",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ),

              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 30.0),
                title: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductionHome()),
                      );
                    },
                    child: const Text(
                      "PRODUCTION",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ),

              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 30.0),
                title: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CemeteryHome()),
                      );
                    },
                    child: const Text(
                      "CEMETERY",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ),

              // ElevatedButton(
              //     onPressed: () {},
              //     child: const Text(
              //       'INSTALLATION',
              //       style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white),
              //     )),
              // ElevatedButton(
              //     onPressed: () {},
              //     child: const Text(
              //       'PRODUCTION',
              //       style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white),
              //     )),
              // ElevatedButton(
              //     onPressed: () {},
              //     child: const Text(
              //       'CEMETETY',
              //       style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white),
              //     )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
