import 'package:flutter/material.dart';
import 'package:mps_app/pages/home.dart';
import 'package:mps_app/utils/requests/all_requests.dart';
import 'package:mps_app/widgets/alert_dialog.dart';

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
                                  var responseData = await AllRequests.login(
                                      emailController.text,
                                      passwordController.text);
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (responseData == 200) {
                                    emailController.text = "";
                                    passwordController.text = "";
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return const Home();
                                      },
                                    ), (route) => false);
                                  } else if (responseData == 422) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertDialogWidget();
                                        });
                                    emailController.text = "";
                                    passwordController.text = "";
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Error...!"),
                                            content: const Text(
                                                "Sorry for inconvenience...! Some Error occur."),
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
                                    emailController.text = "";
                                    passwordController.text = "";
                                  }
                                }
                              },
                            )),
                      ],
                    )),
              ));
  }
}
