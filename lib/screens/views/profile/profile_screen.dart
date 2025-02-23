import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    ;
    return Scaffold(
      body: ProfileScreen(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        showDeleteConfirmationDialog: true,
        showMFATile: true,
        actions: [
          SignedOutAction((context) {
            context.go("/");
          }),
        ],
        children: const [],
      ),
    );
  }
}
