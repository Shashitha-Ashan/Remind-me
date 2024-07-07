import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardScreen2 extends StatelessWidget {
  const OnboardScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/push_notifications.svg",
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.35,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Never Miss a Birthday!",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            textAlign: TextAlign.center,
            "Get timely reminders for your loved ones' birthdays with our push notifications. Stay connected and make every celebration special!",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
