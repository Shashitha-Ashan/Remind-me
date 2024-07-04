import 'package:birth_daily/screens/views/add_birthday/add_birthday.dart';
import 'package:birth_daily/screens/views/calendar/birthday_calendar.dart';
import 'package:birth_daily/screens/views/home/home.dart';
import 'package:birth_daily/screens/views/home/home_page.dart';
import 'package:birth_daily/screens/views/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;
  final List<Widget> _navList = [
    const NavigationDestination(
      icon: Icon(
        Icons.home_filled,
        color: Colors.white,
      ),
      label: "Home",
    ),
    const NavigationDestination(
        icon: Icon(
          Icons.calendar_month,
          color: Colors.white,
        ),
        label: "Calendar"),
    const NavigationDestination(
        icon: Icon(
          Icons.card_giftcard_rounded,
          color: Colors.white,
        ),
        label: "Wishes"),
    const NavigationDestination(
        icon: Icon(
          Icons.settings,
          color: Colors.white,
        ),
        label: "Settings"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle:
                WidgetStatePropertyAll(TextStyle(color: Colors.white))),
        child: NavigationBar(
          onDestinationSelected: (value) {
            setState(() {
              currentPageIndex = value;
            });
          },
          destinations: _navList,
          height: 65,
          backgroundColor: const Color(0xFFE85566),
          animationDuration: const Duration(milliseconds: 300),
          indicatorColor: Color(0xFFE48994),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: currentPageIndex,
        ),
      ),
      body: <Widget>[
        Home(),
        BirthdayCalendar(),
        Center(
          child: Text("Wishes"),
        ),
        SettingsPage()
      ][currentPageIndex],
    );
  }
}
