import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String msg;
  final String msgTitle;

  const AlertDialogWidget({
    required this.msg,
    required this.msgTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(msgTitle),
      content: Text(msg),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
