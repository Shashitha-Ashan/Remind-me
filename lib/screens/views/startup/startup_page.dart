import 'package:birth_daily/screens/views/main/main_page.dart';
import 'package:birth_daily/utils/constants/color_const.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.35,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFA330D8)),
                                  onPressed: () {
                                    context.push("/register");
                                  },
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                        color: kFontColorPositive,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      surfaceTintColor: Color(0xFFA330D8)),
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
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  " Or ",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GoogleSignInIconButton(
                                  size: 25,
                                  loadingIndicator: CircularProgressIndicator(),
                                  clientId:
                                      "962001695927-35sjl1et0tihk884hfkqvc0u6gqqu8tu.apps.googleusercontent.com"),
                              SizedBox(
                                width: 20,
                              ),
                              AppleSignInIconButton(
                                  size: 25,
                                  loadingIndicator:
                                      CircularProgressIndicator()),
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
            return const MainPage();
          }
        });
  }
}
