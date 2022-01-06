import 'package:flutter/material.dart';
import 'package:mps_app/pages/home.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        iconSize: 30,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_arrow_left),
            label: 'Back',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_arrow_right),
            label: 'Forward',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ));
              break;
            case 1:
              Navigator.pop(context);
              break;
            case 2:
              break;
            case 3:
              print("Setting");
              break;
            default:
          }
        });
  }
}
