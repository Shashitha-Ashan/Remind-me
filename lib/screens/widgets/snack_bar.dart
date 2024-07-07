import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showSnackBar(
    {required String message,
    required Color bkgColor,
    required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 2),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(message),
        IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ))
      ],
    ),
    backgroundColor: bkgColor,
  ));
}
