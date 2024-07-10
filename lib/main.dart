import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/blocs/preference/preference_bloc.dart';
import 'package:birth_daily/firebase_options.dart';
import 'package:birth_daily/helpers/preference_helper.dart';
import 'package:birth_daily/repositories/birthday_list/birthday_list.dart';
import 'package:birth_daily/repositories/preference/preferece_repo.dart';
import 'package:birth_daily/routes/routes.dart';
import 'package:birth_daily/utils/themes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/birthdays/birthday_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  InitialPrefernce initialPref = await PreferenceHelper.getInitialPreferences();
  await FirebaseMessages.initFCM();
  runApp(MainApp(
    initialPrefernce: initialPref,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.initialPrefernce});
  final InitialPrefernce initialPrefernce;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => BirthdayRepo(),
        ),
        RepositoryProvider(
          create: (context) => BirthdayListRepo(),
        ),
        RepositoryProvider(
          create: (context) =>
              PrefereceRepo(initialPrefernce: initialPrefernce),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BirthdaysBloc(context.read<BirthdayRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                PreferenceBloc(prefereceRepo: context.read<PrefereceRepo>()),
          ),
        ],
        child: BlocBuilder<PreferenceBloc, PreferenceState>(
            builder: (context, state) {
          print(state);
          if (state is ThemeToggleState) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: routers,
              theme: state.themeStatus ? darkTheme : lightTheme,
            );
          }
          if (state is NotificationToggleState) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: routers,
              theme: state.themeStatus ? darkTheme : lightTheme,
            );
          }
          if (state is PreferenceInitial) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: routers,
              theme:
                  state.initialPrefernce.themeStatus! ? darkTheme : lightTheme,
            );
          }
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: routers,
            theme: lightTheme,
          );
        }),
      ),
    );
  }
}

class FirebaseMessages {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> initFCM() async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.getToken();
  }
}
