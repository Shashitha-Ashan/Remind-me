import 'package:birth_daily/screens/views/home/fancy_home_page.dart';
import 'package:birth_daily/screens/views/home/home_page.dart';
import 'package:birth_daily/utils/constants/color_const.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: Scaffold(
                backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                body: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Welcome Back",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(fontSize: 30),
                          ),
                          SvgPicture.asset(
                            "assets/svg/login.svg",
                            width: 400,
                            height: 300,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFA330D8)),
                                  onPressed: () {
                                    context.push("/signup");
                                  },
                                  child: const Text(
                                    "Sign in with",
                                    style: TextStyle(
                                        color: kFontColorPositive,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      surfaceTintColor: Color(0xFFA330D8)),
                                  onPressed: () {},
                                  child: const Text(
                                    "Log In with Email",
                                    style: TextStyle(
                                        color: kFontColorNegative,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     Padding(
                          //       padding: EdgeInsets.only(
                          //           left:
                          //               MediaQuery.of(context).size.width * 0.1,
                          //           right: MediaQuery.of(context).size.width *
                          //               0.1),
                          //       child: const Row(
                          //         children: [
                          //           Expanded(
                          //             child: Divider(
                          //               thickness: 1,
                          //               color: Colors.black54,
                          //             ),
                          //           ),
                          //           Text(
                          //             " Or ",
                          //             style: TextStyle(color: Colors.black54),
                          //           ),
                          //           Expanded(
                          //             child: Divider(
                          //               thickness: 1,
                          //               color: Colors.black54,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       height: 20,
                          //     ),
                          //     const Text(
                          //       "Login with",
                          //       style: TextStyle(
                          //           color: kFontColorPositive, fontSize: 16),
                          //     ),
                          //     const SizedBox(
                          //       height: 10,
                          //     ),
                          //     // _google_facebook_login(),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const HomePage();
          }
        });
  }
}
