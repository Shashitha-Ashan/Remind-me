import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.push("/login");
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}
