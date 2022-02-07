import 'package:flutter/material.dart';
import 'package:mps_app/pages/collaborations.dart';
import 'package:mps_app/pages/login.dart';
import 'package:mps_app/utils/requests/all_requests.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            title: const Text(
              'Collaboration',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              // close the drawer
              Navigator.pop(context);
              // Update the state of the app
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Collaborations()),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            title: const Text(
              'Open Orders',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            title: const Text(
              'About Us',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            title: const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            title: const Text(
              'LOG OUT',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              AllRequests.logOut();
              Navigator.pop(context);

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Login()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
