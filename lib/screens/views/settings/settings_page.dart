// ignore_for_file: non_constant_identifier_names

import 'package:birth_daily/screens/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black);
    Color iconColor = const Color(0xFF4849A0); //  0xFF5E00F5

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CategoryTitle(title: "General"),
              SettingTile(
                leading: Icon(
                  Icons.person_2,
                  color: iconColor,
                ),
                title: Text(
                  "Profile Infomation",
                  style: textStyle,
                ),
                onTap: () => context.push("/profile"),
              ),
              // Notifications on off setting
              Gap(),
              SettingTile(
                leading: Icon(
                  Icons.notifications_active,
                  color: iconColor,
                ),
                title: Text(
                  "App Notifications",
                  style: textStyle,
                ),
                subtitle: const Text(
                    "Allow the app to send notification about upcoming bithdays"),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
              // Notifications time setting
              Gap(),
              SettingTile(
                onTap: () {
                  context.push("/onboarding");
                },
                leading: Icon(
                  Icons.access_time,
                  color: iconColor,
                ),
                title: Text(
                  "Notification Time",
                  style: textStyle,
                ),
                subtitle: const Text("12:00 AM"),
              ),
              // Theme setting
              Gap(),
              SettingTile(
                leading: Icon(
                  Icons.brightness_4,
                  color: iconColor,
                ),
                title: Text(
                  "Theme",
                  style: textStyle,
                ),
                subtitle: const Text("Light"),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              // about setting
              CategoryTitle(title: "About App"),
              SettingTile(
                leading: Icon(
                  Icons.lock,
                  color: iconColor,
                ),
                title: Text(
                  "Privacy Policy",
                  style: textStyle,
                ),
              ),
              Gap(),
              SettingTile(
                onTap: () => context.push("/dev-info"),
                leading: Icon(
                  Icons.info,
                  color: iconColor,
                ),
                title: Text(
                  "About Us",
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CategoryTitle({required String title}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            title,
            style: const TextStyle(color: Color(0xFFE85566), fontSize: 15),
          ),
        ),
      ],
    );
  }

  Widget Gap() {
    return const SizedBox(
      height: 15,
    );
  }
}
