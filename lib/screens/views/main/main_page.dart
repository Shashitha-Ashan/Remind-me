import 'package:birth_daily/screens/views/birthday_gift/birthday_gift_page.dart';
import 'package:birth_daily/screens/views/calendar/birthday_calendar.dart';
import 'package:birth_daily/screens/views/home/home.dart';
import 'package:birth_daily/screens/views/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        FontAwesomeIcons.house,
        color: Colors.white,
      ),
      label: "Home",
    ),
    const NavigationDestination(
        icon: Icon(
          FontAwesomeIcons.calendarDay,
          color: Colors.white,
        ),
        label: "Calendar"),
    const NavigationDestination(
        icon: Icon(
          FontAwesomeIcons.gift,
          color: Colors.white,
        ),
        label: "Wishes"),
    const NavigationDestination(
        icon: Icon(
          FontAwesomeIcons.gear,
          color: Colors.white,
        ),
        label: "Settings"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
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
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          animationDuration: const Duration(milliseconds: 300),
          indicatorColor: const Color(0xFFE48994),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: currentPageIndex,
        ),
      ),
      body: <Widget>[
        const HomePage(),
        const BirthdayCalendar(),
        const BirthdayGiftPage(),
        const SettingsPage()
      ][currentPageIndex],
    );
  }
}
