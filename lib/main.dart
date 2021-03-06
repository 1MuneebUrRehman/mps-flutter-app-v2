import 'package:flutter/material.dart';
import 'package:mps_app/pages/home.dart';
import 'package:mps_app/pages/login.dart';
import 'package:mps_app/pages/production/laser/laser_form.dart';
import 'package:mps_app/pages/production/laser/laser_form_list.dart';
import 'package:mps_app/pages/production/porcelain/porcelain_form.dart';
import 'package:mps_app/pages/production/porcelain/porcelain_form_list.dart';
import 'package:mps_app/pages/production/sandblasting/sandblasting_form.dart';
import 'package:mps_app/pages/production/sandblasting/sandblasting_form_list.dart';
import 'package:mps_app/utils/classes/custom_shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CustomSharedPreferences.init();
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
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
        '/productionPicture': (context) => const PorcelainFormList(),
        '/productionPicture/index': (context) => const ProductionForm(
              title: 'OC Picture (Porcelain) Production Form',
              dataId: "0",
            ),
        '/productionPicture/add': (context) => const ProductionForm(
              title: 'OC Picture (Porcelain) Production Form',
              dataId: "0",
            ),
        '/productionSandblasting': (context) => const SandBlastingFormList(),
        '/productionSandblasting/index': (context) => const SandBlastingForm(
              title: 'Sandblasting Production Form',
              dataId: "0",
            ),
        '/productionSandblasting/add': (context) => const SandBlastingForm(
              title: 'Sandblasting Production Form',
              dataId: "0",
            ),
        '/productionLaser': (context) => const LaserFormList(),
        '/productionLaser/index': (context) => const LaserForm(
              title: 'Laser Production Form',
              dataId: "0",
            ),
        '/productionLaser/add': (context) => const LaserForm(
              title: 'Laser Production Form',
              dataId: "0",
            ),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    var token = await CustomSharedPreferences.getToken();
    if (token != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => const Login()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : const Login());
  }
}
