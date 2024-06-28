import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    ;
    return Scaffold(
      body: ProfileScreen(
        showDeleteConfirmationDialog: true,
        showMFATile: true,
        actions: [
          SignedOutAction((context) {
            Navigator.pushReplacementNamed(context, '/sign-in');
          }),
        ],
        children: const [],
      ),
    );
  }
}
