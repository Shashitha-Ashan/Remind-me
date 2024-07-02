import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterScreen(
      showPasswordVisibilityToggle: true,
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          context.go("/main");
        }),
      ],
      providers: [
        EmailAuthProvider(),
      ],
    );
  }
}
