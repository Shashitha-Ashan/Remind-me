// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Welcome to RemindMe",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 29, fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
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
                            "Don't have an account ? ",
                            textAlign: TextAlign.left,
                          ),
                          GestureDetector(
                              onTap: () {
                                context.push("/signup");
                              },
                              child: Text(
                                "Sign Up",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 0, 0)),
                              )),
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
    );
  }

  Widget _form() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          decoration: InputDecoration(
              hintText: "Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.remove_red_eye),
              labelText: "Password",
              hintText: "Password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            context.go("/");
          },
          child: Text(
            "Forgot password ?",
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(
          height: 10,
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
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

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
}
