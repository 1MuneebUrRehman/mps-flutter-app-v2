import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReusableWidgets {
  static getAppBar() {
    return AppBar(
      centerTitle: true,
      title: Image.asset('assets/logo.png', fit: BoxFit.cover),
      foregroundColor: Colors.black,
      backgroundColor: Colors.white38,
      actions: <Widget>[
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          tooltip: 'Show Snackbar',
          itemBuilder: (context) => [],
        ),
      ],
    );
  }
}
