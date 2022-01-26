import 'package:flutter/material.dart';

class AlertDialogWidget extends StatefulWidget {
  const AlertDialogWidget({Key? key}) : super(key: key);

  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AlertDialog(
        title: const Text("Error...!"),
        content: const Text("Email and Password not Matched...!"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("OK"))
        ],
      ),
    );
  }
}
