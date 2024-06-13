// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:birth_daily/screens/components/form_text_field.dart';
import 'package:birth_daily/screens/components/horizontal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.lock,
              size: 100,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.76,
              padding:
                  EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Welcome back",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  _form(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ? ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go("/");
                        },
                        child: Text(
                          "Sign up",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 60,
                  // ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget _form() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FormTextField(
          hintText: "Email",
          obscure: false,
          textEditingController: TextEditingController(),
        ),
        SizedBox(
          height: 20,
        ),
        FormTextField(
          textEditingController: TextEditingController(),
          hintText: "Password",
          obscure: true,
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
        HorizontalButton(
          buttonName: "Login",
        ),
      ],
    );
  }
}
