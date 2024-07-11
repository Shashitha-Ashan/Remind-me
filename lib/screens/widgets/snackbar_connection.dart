import 'package:flutter/material.dart';

void showConnectionErrorSnackBar(
    {required BuildContext context,
    required String message,
    required Color bkgColor,
    required IconData icon}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: bkgColor,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(
          width: 20,
        ),
        Text(
          message,
          style: const TextStyle(color: Colors.white),
        )
      ],
    ),
    duration: const Duration(seconds: 3),
  ));
}
