import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/blocs/preference/preference_bloc.dart';
import 'package:birth_daily/firebase_options.dart';
import 'package:birth_daily/helpers/preference_helper.dart';
import 'package:birth_daily/repositories/birthday_list/birthday_list.dart';
import 'package:birth_daily/repositories/preference/preferece_repo.dart';
import 'package:birth_daily/routes/routes.dart';
import 'package:birth_daily/utils/themes.dart';
import 'package:birth_daily/work_manager.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

import 'repositories/birthdays/birthday_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    '1',
    'birthdayCount',
    frequency: Duration(hours: 1),
  );
  InitialPrefernce initialPref = await PreferenceHelper.getInitialPreferences();
  // await FirebaseMessages.initFCM();
  runApp(MainApp(
    initialPreference: initialPref,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.initialPreference});
  final InitialPrefernce initialPreference;
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
              PrefereceRepo(initialPrefernce: initialPreference),
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
          bool themeStatus = false;

          if (state is ThemeToggleState) {
            themeStatus = state.themeStatus;
          }
          if (state is NotificationToggleState) {
            themeStatus = state.themeStatus;
          }
          if (state is PreferenceInitial) {
            themeStatus = state.initialPrefernce.themeStatus!;
          }

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: routers,
            theme: themeStatus ? darkTheme : lightTheme,
          );
        }),
      ),
    );
  }
}

// class FirebaseMessages {
//   static final _firebaseMessaging = FirebaseMessaging.instance;

//   static Future<void> initFCM() async {
//     await _firebaseMessaging.requestPermission();
//     final token = await _firebaseMessaging.getToken();
//     print(token);
//   }
// }
