// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _google_facebook_login() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {},
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

    Widget _form() {
      return Column(
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Confirm password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            height: 40,
            elevation: 20,
            minWidth: double.infinity,
            shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5)),
            color: Colors.red,
            onPressed: () {},
            child: const Text(
              "Sign up",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    }

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              opacity: 0.1,
              image: AssetImage("assets/backgrounds/back.png"),
              fit: BoxFit.fill),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(43, 255, 0, 0),
              Color.fromARGB(0, 255, 0, 0),
              Color.fromARGB(0, 255, 0, 0),
              Color.fromARGB(0, 255, 0, 0),
            ]),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Welcome to RemidMe",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                      _form(),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Or"),
                      _google_facebook_login(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account ? ",
                              textAlign: TextAlign.left,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.push("/login");
                              },
                              child: Text(
                                "Log in",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 0, 0)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
