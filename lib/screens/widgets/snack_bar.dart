import 'package:flutter/material.dart';

void showSnackBar(
    {required String message,
    required Color bkgColor,
    required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 2),
    content: Text(message),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
    backgroundColor: bkgColor,
  ));
}
