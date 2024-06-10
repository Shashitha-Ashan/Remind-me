import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _google_facebook_login() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {
              context.push("/home");
            },
            child: Image.asset(
              'assets/icons/google.png',
              width: 60,
            ),
          ),
          MaterialButton(
            onPressed: () {},
            child: Image.asset(
              'assets/icons/fb.png',
              width: 60,
            ),
          ),
        ],
      );
    }

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 23, 75, 186),
            Color.fromARGB(255, 23, 54, 55),
          ])),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Welcome Back",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.white, fontSize: 30)),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(),
                          onPressed: () {
                            context.push("/signup");
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            context.push("/login");
                          },
                          child: const Text(
                            "Log In",
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Login with",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      _google_facebook_login(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
