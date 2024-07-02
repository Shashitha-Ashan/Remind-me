import 'package:birth_daily/blocs/theme/theme_bloc.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool themestate = false;
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 10,
            title: const Text('Settings'),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
          body: ListView(
            children: [
              settingSectionTile('Genaral Settings'),
              divider(),
              settingSectionTile('Theme'),
              SettingTile(
                onTap: () {},
                title: 'backup & restore',
                description: 'Dark',
                trailingWidget: Switch(
                  value: themestate,
                  onChanged: (value) {
                    if (value == false) {
                      themestate = false;
                      print(value);
                      context.read<ThemeBloc>().add(LightThemeEvent());
                    }
                    if (value == true) {
                      themestate = true;
                      print(value);
                      context.read<ThemeBloc>().add(DarkThemeEvent());
                    }
                  },
                ),
              ),
              divider(),
              settingSectionTile('info'),
              SettingTile(
                onTap: () {
                  context.push("/developerinfo");
                },
                title: 'About us',
                description: 'Developer information',
              ),
              divider(),
              settingSectionTile('Version'),
              const SettingTile(
                title: 'RemindMe',
                description: 'Current version: RemindMe 1.0.0',
              ),
              SignOutButton()
            ],
          ),
        );
      },
    );
  }

  Divider divider() {
    return const Divider(
      thickness: 1.5,
      height: 20,
    );
  }

  Container settingSectionTile(String title) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.only(left: 5),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile(
      {super.key,
      this.isDisable = true,
      required this.title,
      required this.description,
      this.trailingWidget,
      this.onTap});
  final String title;
  final String description;
  final Widget? trailingWidget;
  final Function()? onTap;
  final bool isDisable;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        shape: const Border(),
        enabled: isDisable,
        // tileColor: Colors.transparent,
        enableFeedback: true,
        title: Text(title),
        subtitle: Text(description),
        trailing: trailingWidget,
      ),
    );
  }
}
