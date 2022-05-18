import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String message) {
  // configura o button
  Widget okButton = FlatButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: const Text("Login"),
    content: Text(message),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
