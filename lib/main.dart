import 'package:birth_daily/features/home/screen/home.dart';
import 'package:birth_daily/features/login/screen/login_screen.dart';
import 'package:birth_daily/features/signup/screen/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: "/signup",
      builder: (context, state) => const SignUp(),
    ),
  ]);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
