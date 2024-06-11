import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text('Settings'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          settingSectionTile('Genaral Settings'),
          SettingTile(
            isDisable: false,
            onTap: () {},
            title: 'backup & restore',
            description: 'Back up your birthdays in the cloud',
          ),
          divider(),
          settingSectionTile('Theme'),
          divider(),
          settingSectionTile('info'),
          SettingTile(
            onTap: () {},
            title: 'About us',
            description: 'Developer information',
          ),
          divider(),
          settingSectionTile('Version'),
          const SettingTile(
            title: 'Birthday Alert',
            description: 'Current version:Birthday Alert 1.0.0',
          ),
        ],
      ),
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
