import 'package:flutter/material.dart';
import 'package:mps_app/pages/home.dart';
import 'package:mps_app/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late SharedPreferences sharedPreferences;
  final bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => const Login()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : const Login()
    );
  }
}
