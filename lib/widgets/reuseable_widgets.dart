import 'package:flutter/material.dart';

class ReusableWidgets {
  static getAppBar() {
    return AppBar(
      centerTitle: true,
      title: Image.asset('assets/logo.png', fit: BoxFit.cover),
      foregroundColor: Colors.black,
      backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
      actions: <Widget>[
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          tooltip: 'Show Snackbar',
          itemBuilder: (context) => [],
        ),
      ],
    );
  }

  static getAppBarForm(String title) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 15),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
    );
  }
}
