import 'package:flutter/material.dart';

class ConfirmatonAlertDialog extends StatefulWidget {
  const ConfirmatonAlertDialog(this.function, {super.key});
  final function;

  @override
  State<ConfirmatonAlertDialog> createState() =>
      _ConfirmatonAlertDialogState(function);
}

class _ConfirmatonAlertDialogState extends State<ConfirmatonAlertDialog> {
  final function;
  _ConfirmatonAlertDialogState(this.function);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm this List?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No")),
        TextButton(onPressed: function, child: const Text("Confirm")),
      ],
    );
  }
}
