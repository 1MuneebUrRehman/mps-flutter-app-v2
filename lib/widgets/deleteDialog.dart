import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatefulWidget {
  const DeleteAlertDialog({Key? key}) : super(key: key);

  @override
  _DeleteAlertDialogState createState() => _DeleteAlertDialogState();
}

class _DeleteAlertDialogState extends State<DeleteAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AlertDialog(
        title: const Text("Delete...!"),
        content: const Text("Are You Sure you want to Delete ...!"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text("Yes")),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("No"))
        ],
      ),
    );
  }
}
