import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/blocs/theme/theme_bloc.dart';
import 'package:birth_daily/firebase_options.dart';
import 'package:birth_daily/routes/routes.dart';

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
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => BirthdayRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BirthdaysBloc(context.read<BirthdayRepo>()),
          ),
          BlocProvider(
            create: (context) => ThemeBloc(),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            if (state is ThemeInitialState) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: routers,
                theme: state.themeData,
              );
            }
            if (state is DarkThemeState) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: routers,
                theme: state.themeData,
              );
            }
            if (state is LightThemeState) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: routers,
                theme: state.themeData,
              );
            }
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: routers,
            );
          },
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
