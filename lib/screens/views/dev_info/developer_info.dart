import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DevInfoPage extends StatelessWidget {
  const DevInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF653611),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              radius: 1.4,
              tileMode: TileMode.clamp,
              colors: [Colors.white38, Color(0xFF653611)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.cancel_rounded,
                        color: Colors.black87,
                      ))
                ],
              ),
              const Spacer(),
              Image.asset(
                'assets/logo.png',
                alignment: Alignment.center,
                height: 200,
                width: 200,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '© 2023 The Coffee code',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  elevatedButtonWidget('Rate this App', Icons.star, () {}),
                  elevatedButtonWidget(
                      'Github', FontAwesomeIcons.github, () {}),
                  elevatedButtonWidget(
                      'Linkedin', FontAwesomeIcons.linkedin, () {}),
                ],
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding elevatedButtonWidget(String text, IconData icon, Function() fun) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
      child: MaterialButton(
        elevation: 10,
        enableFeedback: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        onPressed: fun,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black87,
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                text,
                style: const TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
