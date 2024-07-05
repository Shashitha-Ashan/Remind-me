import 'package:birth_daily/screens/views/add_birthday/add_birthday.dart';
import 'package:birth_daily/screens/views/calendar/birthday_calendar.dart';
import 'package:birth_daily/screens/views/main/main_page.dart';
import 'package:birth_daily/screens/views/profile/profile_screen.dart';
import 'package:birth_daily/screens/views/search/search_page.dart';
import 'package:birth_daily/screens/views/settings/settings_page.dart';
import 'package:birth_daily/screens/views/startup/startup_page.dart';
import 'package:birth_daily/screens/views/login/login_screen.dart';
import 'package:birth_daily/screens/views/signup/sign_up.dart';
import 'package:go_router/go_router.dart';

final routers = GoRouter(routes: <RouteBase>[
  GoRoute(path: "/", builder: (context, state) => const StartupPage()),
  GoRoute(
    path: "/login",
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: "/register",
    builder: (context, state) => const AuthGate(),
  ),
  GoRoute(
    path: "/main",
    builder: (context, state) => const MainPage(),
  ),
  GoRoute(
    path: "/settings",
    builder: (context, state) => const SettingsPage(),
  ),
  GoRoute(
    path: "/search",
    builder: (context, state) => SearchPage(),
  ),
  GoRoute(
    path: "/profile",
    builder: (context, state) => const Profile(),
  ),
  GoRoute(
    path: "/birthday_calendar",
    builder: (context, state) => const BirthdayCalendar(),
  ),
  GoRoute(
    path: "/add-birthday",
    builder: (context, state) => const AddBirthday(),
  ),
]);
