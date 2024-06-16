import 'package:birth_daily/firebase_options.dart';
import 'package:birth_daily/screens/views/home/home_page.dart';
import 'package:birth_daily/screens/views/search/search_page.dart';
import 'package:birth_daily/screens/views/settings/settings_page.dart';
import 'package:birth_daily/screens/views/startup/startup_page.dart';
import 'package:birth_daily/screens/views/login/login_screen.dart';
import 'package:birth_daily/screens/views/signup/sign_up.dart';
import 'package:birth_daily/utils/themes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) => SignInScreen(
        providers: [
          EmailAuthProvider(),
          GoogleProvider(
              clientId:
                  "866459352486-odg15a713glo09r2krcau6kmir3d9cjt.apps.googleusercontent.com")
        ],
      ),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: "/signup",
      builder: (context, state) => const SignUp(),
    ),
    GoRoute(
      path: "/home",
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: "/settings",
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: "/search",
      builder: (context, state) => const SearchPage(),
    ),
  ]);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: textTheme,
    );
  }
}
