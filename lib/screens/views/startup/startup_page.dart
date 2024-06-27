import 'package:birth_daily/screens/views/home/fancy_home_page.dart';
import 'package:birth_daily/screens/views/home/home_page.dart';
import 'package:birth_daily/utils/constants/color_const.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: kFontColorPositive),
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
                                    style: TextStyle(
                                        color: kFontColorNegative,
                                        fontSize: 22),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * 0.1,
                                    right: MediaQuery.of(context).size.width *
                                        0.1),
                                child: const Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.white54,
                                      ),
                                    ),
                                    Text(
                                      " Or ",
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Login with",
                                style: TextStyle(
                                    color: kFontColorPositive, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // _google_facebook_login(),
                              const GoogleSignInButton(
                                loadingIndicator: CircularProgressIndicator(),
                                clientId:
                                    "866459352486-odg15a713glo09r2krcau6kmir3d9cjt.apps.googleusercontent.com",
                              ),
                            ],
                          )
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
