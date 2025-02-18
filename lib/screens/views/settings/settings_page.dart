// ignore_for_file: non_constant_identifier_names

import 'package:birth_daily/blocs/preference/preference_bloc.dart';
import 'package:birth_daily/screens/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool themeButtonVal = false;
  bool notificationButtonVal = true;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    TextStyle? titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        );
    TextStyle? subtitleStyle = Theme.of(context).textTheme.labelSmall!.copyWith(
          fontSize: 13,
        );
    Color iconColor = const Color(0xFF4849A0); //  0xFF5E00F5

    return BlocBuilder<PreferenceBloc, PreferenceState>(
      builder: (context, state) {
        print(state);
        if (state is PreferenceInitial) {
          notificationButtonVal = state.initialPrefernce.notificationStatus!;
          themeButtonVal = state.initialPrefernce.themeStatus!;
        }
        if (state is ThemeToggleState) {
          themeButtonVal = state.themeStatus;
        }
        if (state is NotificationToggleState) {
          notificationButtonVal = state.notificationStatus;
        }

        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
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
                      "Profile Information",
                      style: titleStyle,
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
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      "Allow the app to send notification about upcoming bithdays",
                      style: subtitleStyle,
                    ),
                    trailing: Switch(
                      value: notificationButtonVal,
                      onChanged: (value) {
                        context.read<PreferenceBloc>().add(
                            NotificationToggleEvent(notificationStatus: value));
                      },
                    ),
                  ),
                  // Notifications time setting
                  // Gap(),
                  // SettingTile(
                  //   onTap: () {
                  //     context.push("/onboarding");
                  //   },
                  //   leading: Icon(
                  //     Icons.access_time,
                  //     color: iconColor,
                  //   ),
                  //   title: Text(
                  //     "Notification Time",
                  //     style: titleStyle,
                  //   ),
                  //   subtitle: const Text("12:00 AM"),
                  // ),
                  // Theme setting
                  Gap(),
                  SettingTile(
                    leading: Icon(
                      Icons.brightness_4,
                      color: iconColor,
                    ),
                    title: Text(
                      "Theme",
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      themeButtonVal ? "Dark" : "Light",
                      style: subtitleStyle,
                    ),
                    trailing: Switch(
                      value: themeButtonVal,
                      onChanged: (value) {
                        context
                            .read<PreferenceBloc>()
                            .add(ThemeToggleEvent(themeStatus: value));
                      },
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
                      style: titleStyle,
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
                      style: titleStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
