import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/firebase_options.dart';
import 'package:birth_daily/screens/views/home/home_page.dart';
import 'package:birth_daily/screens/views/search/search_page.dart';
import 'package:birth_daily/screens/views/settings/settings_page.dart';
import 'package:birth_daily/screens/views/startup/startup_page.dart';
import 'package:birth_daily/screens/views/login/login_screen.dart';
import 'package:birth_daily/screens/views/signup/sign_up.dart';
import 'package:birth_daily/utils/themes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/birthdays/birthday_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessages().initFCM();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _router = GoRouter(routes: <RouteBase>[
    GoRoute(path: "/", builder: (context, state) => const StartupPage()),
    GoRoute(
      path: "/login",
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: "/signup",
      builder: (context, state) => const AuthGate(),
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
    return RepositoryProvider(
      create: (context) => BirthdayRepo(),
      child: BlocProvider(
        create: (context) => BirthdaysBloc(context.read<BirthdayRepo>()),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          theme: textTheme,
        ),
      ),
    );
  }
}

class FirebaseMessages {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initFCM() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();
    print(token);
  }
}
