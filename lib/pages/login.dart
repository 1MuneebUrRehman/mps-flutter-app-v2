import 'package:flutter/material.dart';
import 'package:mps_app/pages/home.dart';
import 'package:mps_app/utils/classes/custom_shared_preferences.dart';
import 'package:mps_app/utils/requests/all_requests.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  static String loginUrl = "https://mps-dev.uforialogic.com/api/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white38,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _loginFormKey,
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'LOG-IN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            )),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Valid Email Address';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Login'),
                              onPressed: () async {
                                if (_loginFormKey.currentState!.validate()) {
                                  try {
                                    Map data = {
                                      'email': emailController.text,
                                      'password': passwordController.text
                                    };
                                    var response = await http.post(
                                        Uri.parse(loginUrl),
                                        body: data,
                                        headers: {
                                          "Accept": "application/json",
                                          "Access-Control_Allow_Origin": "*"
                                        });
                                    emailController.text = "";
                                    passwordController.text = "";
                                    if (response.statusCode == 200) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      emailController.text = "";
                                      passwordController.text = "";
                                      var jsonResponse =
                                          json.decode(response.body);

                                      await CustomSharedPreferences.setToken(
                                          jsonResponse['auth_token']);

                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return const Home();
                                        },
                                      ), (route) => false);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Error...!"),
                                              content: const Text(
                                                  "Email and Password Not Matched...!"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    },
                                                    child: const Text("OK"))
                                              ],
                                            );
                                          });
                                    }
                                  } catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Error...!"),
                                            content: Text(e.toString()),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, true);
                                                  },
                                                  child: const Text("OK"))
                                            ],
                                          );
                                        });
                                  }
                                }
                              },
                            )),
                      ],
                    )),
              ));
  }
}
